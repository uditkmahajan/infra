resource "tls_private_key" "my-key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "ec2_public_key" {
  key_name   = "${var.environment}-${var.app_name}-key"
  public_key = tls_private_key.my-key.public_key_openssh
}

resource "local_file" "saving_key" {
  content  = tls_private_key.my-key.private_key_pem
  filename = "/Users/Udit.Mahajan/Downloads/${var.environment}-${var.app_name}-key.pem"
}
