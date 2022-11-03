
resource "aws_instance" "jump-host" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_id
  availability_zone           = var.az
  associate_public_ip_address = true
  security_groups             = ["${var.sg}"]
  subnet_id                   = var.subnet
  tags = {
    Name = "${var.environment}-${var.app_name}-jump-host"
  }
}