module "asg" {
  source           = "./Modules/asg"
  environment      = var.environment
  app_name         = var.app_name
  subnets          = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id]
  target_id        = module.alb.target_id
  ami              = var.ami
  instance_type    = var.instance_type
  key_id           = module.key_pair.key_id
  sg               = module.security.lt_sg_id
  asg_desired_size = var.asg_desired_size
  asg_max_size     = var.asg_max_size
  asg_min_size     = var.asg_min_size
}