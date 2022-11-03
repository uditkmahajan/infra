resource "aws_subnet" "main" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr
  availability_zone = var.az
  tags = {
    Name = "${var.environment}-${var.app_name}-${var.subnet_name}"
  }
}