module "jump_host" {
  source        = "./Modules/jumphost"
  environment   = var.environment
  app_name      = var.app_name
  ami           = var.ami
  instance_type = var.instance_type
  az            = element(var.az, 0)
  key_id        = module.key_pair.key_id
  sg            = module.security.jump_sg_id
  subnet        = module.public_subnet_1.subnet_id
}