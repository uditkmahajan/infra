# vpc creation
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.environment}-${var.app_name}-vpc"
  }
}

# internet gateway
resource "aws_internet_gateway" "ig-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-${var.app_name}-ig"
  }
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = var.eip_id
  subnet_id     = var.subnet_id

  tags = {
    Name = "${var.environment}-${var.app_name}-nat"
  }
}
