# module "s3_env" {
#    source = "./Modules/s3"
#    environment = var.environment
#    app_name = var.app_name
#    s3_name = "env-s3"
# }

module "s3_cloudfront" {
  source      = "./Modules/s3"
  environment = var.environment
  app_name    = var.app_name
  s3_name     = "cloudfront-s3"
}