# creating new OAI so that it can be given to s3 bucket
resource "aws_cloudfront_origin_access_identity" "OAI" {
}

resource "aws_cloudfront_distribution" "distribution" {
  # creating custome origin for alb 
  origin {
    domain_name = var.alb_dns
    origin_id   = "alb"
    # means hamara jo origin h wo kiss port pr http/HTTPS request sunega kyoki hum manualy change kr sakte h ki http request hamara orgin ye port pr sune 
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  # we are using default_cache_behavior for the default behvaior of the cloudfront
  enabled             = true
  default_root_object = "" # jab bhi cloudfront url hit ho default path uske sath kya add ho like cf:url/default_path
  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "alb"
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }


  # creating orging for s3 bucket   
  origin {
    domain_name = var.s3_regional_name # prod-memberportal-teamd-cloudfront-s3.s3.ap-northeast-2.amazonaws.com
    origin_id   = "s3"                 # any name 
    # yaha pr OAI de rahe h s3 bucket ko 
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.OAI.cloudfront_access_identity_path
    }
  }

  ordered_cache_behavior {
    path_pattern           = "/memberex/default/*"
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "s3"
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


data "aws_iam_policy_document" "cf_s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.s3_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.OAI.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "cf_policy" {
  bucket = var.s3_id
  policy = data.aws_iam_policy_document.cf_s3_policy.json
}

# resource "aws_cloudfront_cache_policy" "cloudfront_cache_policy" {
#   name        = "Managed-CachingOptimized"
#   comment     = "Default policy when CF compression is enabled"
#   default_ttl = 86400
#   max_ttl     = 31536000
#   min_ttl     = 1

#   parameters_in_cache_key_and_forwarded_to_origin {
#     enable_accept_encoding_brotli = true
#     enable_accept_encoding_gzip   = true
#     cookies_config {
#       cookie_behavior = "none"
#     }
#     headers_config {
#       header_behavior = "none"
#     }
#     query_strings_config {
#       query_string_behavior = "none"
#     }
#   }

#   lifecycle {
#     prevent_destroy = true
#   }
# }