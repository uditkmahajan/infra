# getting iam role
data "aws_iam_role" "codedeployrole" {
  name = "AWSCodeDeployRole"
}

# creating role
# resource "aws_iam_role" "codedeploy_service" {
#   name = "codedeploy-service-role"
# 
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": [
#           "codedeploy.amazonaws.com"
#         ]
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }

# code deploy
resource "aws_codedeploy_app" "codedeploy" {
  compute_platform = "Server"
  name             = "${var.environment}-${var.app_name}-cda"
  tags = {
    "Name" = "${var.environment}-${var.app_name}-cda"
  }
}

# create a deployment group
resource "aws_codedeploy_deployment_group" "cdg" {
  app_name               = aws_codedeploy_app.codedeploy.name
  deployment_group_name  = "${var.environment}-${var.app_name}-cdg"
  deployment_config_name = "CodeDeployDefault.AllAtOnce" # AWS defined deployment config
  autoscaling_groups     = ["${var.asg_id}"]
  service_role_arn       = data.aws_iam_role.codedeployrole.arn
  deployment_style {
    deployment_type = "IN_PLACE"
  }
  auto_rollback_configuration {
    enabled = true
    events = [
      "DEPLOYMENT_FAILURE",
    ]
  }

}