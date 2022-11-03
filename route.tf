module "route" {
  source      = "./Modules/routes"
  vpc_id      = module.vpc.vpc_id
  ig          = module.vpc.ig_id
  nat         = module.vpc.nat_id
  environment = var.environment
  app_name    = var.app_name
  # default_route_table_id = module.vpc.default_route_table_id
  # peer_vpc_id   = module.peer_vpc.peering_id
  public_subnets  = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
  private_subnets = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id, module.private_subnet_3.subnet_id, module.private_subnet_4.subnet_id]
}
