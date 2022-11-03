module "public_subnet_1" {
  source      = "./Modules/subnet"
  vpc_id      = module.vpc.vpc_id
  subnet_name = "public-subnet-1"
  app_name    = var.app_name
  environment = var.environment
  subnet_cidr = element(var.public_subnets_cidr, 0)
  az          = element(var.az, 0)
}

module "public_subnet_2" {
  source      = "./Modules/subnet"
  vpc_id      = module.vpc.vpc_id
  subnet_name = "public-subnet-2"
  app_name    = var.app_name
  environment = var.environment
  subnet_cidr = element(var.public_subnets_cidr, 1)
  az          = element(var.az, 1)
}

module "private_subnet_1" {
  source      = "./Modules/subnet"
  vpc_id      = module.vpc.vpc_id
  subnet_name = "private-subnet-1"
  app_name    = var.app_name
  environment = var.environment
  subnet_cidr = element(var.private_subnets_cidr, 0)
  az          = element(var.az, 0)
}

module "private_subnet_2" {
  source      = "./Modules/subnet"
  vpc_id      = module.vpc.vpc_id
  subnet_name = "private-subnet-2"
  app_name    = var.app_name
  environment = var.environment
  subnet_cidr = element(var.private_subnets_cidr, 1)
  az          = element(var.az, 1)
}

module "private_subnet_3" {
  source      = "./Modules/subnet"
  vpc_id      = module.vpc.vpc_id
  subnet_name = "private-subnet-3"
  app_name    = var.app_name
  environment = var.environment
  subnet_cidr = element(var.private_subnets_cidr, 2)
  az          = element(var.az, 2)
}

module "private_subnet_4" {
  source      = "./Modules/subnet"
  vpc_id      = module.vpc.vpc_id
  subnet_name = "private-subnet-4"
  app_name    = var.app_name
  environment = var.environment
  subnet_cidr = element(var.private_subnets_cidr, 3)
  az          = element(var.az, 3)
}



# module "public_subnet" {
#   count = length(var.public_subnets_cidr)
#   source = "./Modules/subnet"
#  vpc_id      = module.vpc.vpc_id
#   subnet_name = "public-subnet-${count.index+1}"
#   app_name    = var.app_name
#   environment = var.environment
#   subnet_cidr = element(var.public_subnets_cidr, count.index)
#   az          = element(var.az, count.index)
# }

# module "private_subnet" {
#   count = length(var.private_subnets_cidr)
#   source = "./Modules/subnet"
#   vpc_id      = module.vpc.vpc_id
#   subnet_name = "private-subnet-${count.index+1}"
#   app_name    = var.app_name
#   environment = var.environment
#   subnet_cidr = element(var.private_subnets_cidr, count.index)
#   az          = element(var.az, count.index)
# }


