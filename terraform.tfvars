accountID            = "707713643480"
region               = "ap-northeast-2"
vpc_cidr             = "19.5.0.0/16"
public_subnets_cidr  = ["19.5.1.0/24", "19.5.2.0/24"]
private_subnets_cidr = ["19.5.3.0/24", "19.5.4.0/24", "19.5.5.0/24", "19.5.6.0/24"]
environment          = "prod"
app_name             = "memberportal-teamd"
az                   = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c", "ap-northeast-2d"]
instance_type        = "t3.medium"
ami                  = "ami-0c76973fbe0ee100c"
asg_max_size         = 1
asg_min_size         = 1
asg_desired_size     = 1
db_username          = "prodmpteamd"
db_instance_type     = "db.t4g.medium"
db_password          = "s3n52e6h23a"
db_port              = 5432
engine               = "aurora-postgresql"
engine_version       = "12.8"
peer_region = "ap-southeast-2"
peer_vpc_id = "vpc-13fc9476"

# db_security_port                = "5432"
# db_instance_username            = "mportalteamdpg"
# db_instance_password            = "23aK4$RL!56"
# engine                          = "aurora-postgresql"
# engine_version                  = "12.8"
# backup_retention_period         = 3
# preferred_backup_window         = "02:00-03:00"
# preferred_maintenance_window    = "sun:05:00-sun:06:00"
# pg_port                         = "5432"
# ebs_volume_size                 = "100"
# ebs_volume_type                 = "gp2"
# ebs_volume_delete_on_terminaton = "true"
# rds_family                      = "aurora-postgresql12"
# primary_node_type               = "t3.medium"

#Web Server Auto Scaling
web_server_max_size     = "1"
web_server_min_size     = "1"
web_server_desired_size = "1"
web_asg_instance_type   = "t3.medium"
aws_linux_web_ami       = "ami-0c641f2290e9cd048"
#domain_aliases = "caaexp-int.avizva.com"

role_Name   = "sandbox-memberportal-teamd-codedeploy-role"
secret_name = "sandbox-memberportal-teamd-secrets"
