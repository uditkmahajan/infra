module "key_pair" {
  source      = "./Modules/key_pair"
  environment = var.environment
  app_name    = var.app_name
}