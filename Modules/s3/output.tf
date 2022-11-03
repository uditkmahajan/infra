output "s3_id" {
  value = aws_s3_bucket.s3.id
}

output "s3_arn" {
  value = aws_s3_bucket.s3.arn
}

output "s3_regional_name" {
  value = aws_s3_bucket.s3.bucket_regional_domain_name
}