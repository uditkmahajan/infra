variable "region" {
}

variable "az" {
}
# vpc variables
variable "vpc_cidr" {
}

variable "environment" {
}

variable "app_name" {
}

# subnets variables
variable "public_subnets_cidr" {
}

variable "private_subnets_cidr" {
}

# asg variables 
variable "ami" {
}

variable "instance_type" {
}

variable "asg_max_size" {
}

variable "asg_min_size" {
}

variable "asg_desired_size" {
}

# db variables 
variable "db_username" {
}

variable "db_password" {
}

variable "db_instance_type" {
}

variable "db_port" {
}

variable "engine" {
}

variable "engine_version" {
}

variable "peer_region" {
  
}

variable "peer_vpc_id" {
}
variable "accountID" {
}