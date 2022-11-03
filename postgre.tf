module "db" {
  source           = "./Modules/postgres"
  environment      = var.environment
  app_name         = var.app_name
  db_port          = var.db_port
  db_username      = var.db_username
  db_password      = var.db_password
  db_instance_type = var.db_instance_type
  subnets          = [module.private_subnet_3.subnet_id, module.private_subnet_4.subnet_id]
  az               = ["${element(var.az, 2)}", "${element(var.az, 3)}"]
  sg               = [module.security.db_sg_id, module.security.db_sg_for_ec2_id]
  engine           = var.engine
  engine_version   = var.engine_version
}