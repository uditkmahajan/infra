output "vpc_id" {
  value = aws_vpc.main.id
}

output "ig_id" {
  value = aws_internet_gateway.ig-gw.id
}

output "nat_id" {
  value = aws_nat_gateway.nat-gw.id
}

output "default_route_table_id" {
  value = aws_vpc.main.default_route_table_id
}