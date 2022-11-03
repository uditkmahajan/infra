resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.ig
  }

  tags = {
    Name = "${var.environment}-${var.app_name}-public_route"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat
  }



  tags = {
    Name = "${var.environment}-${var.app_name}-private_route"
  }
}

# route table association with subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = element(var.public_subnets, count.index)
}
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = element(var.private_subnets, count.index)
}



# rror waiting for EC2 VPC Peering Connection (pcx-00a58ceb02ecb8a45) create: unexpected state 'failed', wanted target 'active, pending-acceptance'. last error: Failed due to incorrect VPC-ID, Account ID, or overlapping CIDR range