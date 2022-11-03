module "cloudfront" {
  source           = "./Modules/cloudfront"
  alb_dns          = module.alb.alb_dns
  s3_regional_name = module.s3_cloudfront.s3_regional_name
  s3_arn           = module.s3_cloudfront.s3_arn
  s3_id            = module.s3_cloudfront.s3_id
  environment      = var.environment
  app_name         = var.app_name
}