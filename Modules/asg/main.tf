data "aws_iam_instance_profile" "allrole" {
  name = "cloud-watch-iam-role"
}

resource "aws_launch_template" "lt" {
  name = "${var.environment}-${var.app_name}-asg-ec2"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 8
    }
  }

  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_id
  iam_instance_profile {
    arn = data.aws_iam_instance_profile.allrole.arn
    # name = data.aws_iam_role.allrole.name
  }

  vpc_security_group_ids = ["${var.sg}"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.environment}-${var.app_name}-asg-ec2"
    }
  }

  user_data = filebase64("/Users/Udit.Mahajan/terraform/prod-memberportal-project/tomcat.sh")
}



resource "aws_autoscaling_group" "asg" {
  name                      = "${var.environment}-${var.app_name}-asg"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  vpc_zone_identifier = [for i in var.subnets : i]
  target_group_arns   = ["${var.target_id}"]
}

