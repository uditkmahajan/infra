# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#     }
#   }
# }

terraform {
  backend "s3" {
    bucket = "prod-memberportal-teamd-env-s3"
    key    = "Statefiles/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

# provider "aws" {
#   alias  = "peer"
#   region = "ap-southeast-2"

# }

# whenever we are creating resources using terraform then it will created with provider configuration that is default
# but if we want to use/create resources with another region then we create another provider configuration and terraform
# uses default configuration so to use another provider ..we explicitly use it  https://discuss.hashicorp.com/t/get-vpc-id-which-is-in-different-region/21936/2