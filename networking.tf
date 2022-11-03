resource "aws_eip" "eip_nat" {
  vpc = true
}

module "vpc" {
  source      = "./Modules/networking"
  environment = var.environment
  app_name    = var.app_name
  vpc_cidr    = var.vpc_cidr
  eip_id      = aws_eip.eip_nat.id
  subnet_id   = module.public_subnet_1.subnet_id
}
