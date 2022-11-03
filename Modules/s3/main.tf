resource "aws_s3_bucket" "s3" {
  bucket = "${var.environment}-${var.app_name}-${var.s3_name}"

  versioning {
    enabled = true
  }
  tags = {
    Name        = "${var.environment}-${var.app_name}-${var.s3_name}"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.s3.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "private" {
  bucket                  = aws_s3_bucket.s3.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}