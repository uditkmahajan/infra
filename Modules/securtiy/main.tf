# nacl for vpc 
resource "aws_network_acl" "main" {
  vpc_id = var.vpc_id

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    rule_no    = 100
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "${var.environment}-${var.app_name}-nacl"
  }
}

# association of subnets to the nacl
resource "aws_network_acl_association" "main" {
  count          = length(var.subnets)
  network_acl_id = aws_network_acl.main.id
  subnet_id      = element(var.subnets, count.index)
}


# security group for jump host
resource "aws_security_group" "jump-sg" {
  name        = "${var.environment}-${var.app_name}-jumphost-sg"
  description = "Allow All inbound traffic through SSH"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-${var.app_name}-jumphost-sg"
  }
}

resource "aws_security_group" "db_sg_for_ec2" {
  name        = "${var.environment}-${var.app_name}-db-sg-for-ec2"
  description = "sg for db given to ec2 for incoming traffic from db"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.environment}-${var.app_name}-db-sg-for-ec2"
  }
}

# security group for ALB
resource "aws_security_group" "alb-sg" {
  name        = "${var.environment}-${var.app_name}-alb-sg"
  description = "Allow All inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-${var.app_name}-alb-sg"
  }
}

# security group for asg-ec2
resource "aws_security_group" "asg-ec2-sg" {
  name        = "${var.environment}-${var.app_name}-asg-ec2-sg"
  description = "inbound traffic from alb and jump (SSH)"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.jump-sg.id]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "TCP"
    security_groups = [aws_security_group.alb-sg.id]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.db_sg_for_ec2.id]
  }
  # ingress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-${var.app_name}-asg-ec2-sg"
  }
}

# security grooup for database
resource "aws_security_group" "db-sg" {
  name        = "${var.environment}-${var.app_name}-db-sg"
  description = "Allow traffic for DB"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "TCP"
    security_groups = [aws_security_group.asg-ec2-sg.id]
  }

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "TCP"
    security_groups = [aws_security_group.jump-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-${var.app_name}-db-sg"
  }
}