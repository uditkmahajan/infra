module "security" {
  source      = "./Modules/securtiy"
  environment = var.environment
  app_name    = var.app_name
  vpc_id      = module.vpc.vpc_id
  subnets     = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id, module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id, module.private_subnet_3.subnet_id, module.private_subnet_4.subnet_id]
}