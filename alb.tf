module "alb" {
  source      = "./Modules/alb"
  environment = var.environment
  app_name    = var.app_name
  vpc_id      = module.vpc.vpc_id
  sg          = module.security.alb_sg_id
  subnets     = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
}