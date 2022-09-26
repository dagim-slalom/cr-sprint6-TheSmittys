resource "aws_iam_role" "codeDeployRole" {
  name = "codeDeployRole"

  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Effect": "Allow",
            "Principal": {
                "Service": "codedeploy.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
            }
        ]
    }
    EOF
}

resource "aws_iam_policy_attachment" "codeDeployPolicyAttachment" {

  name       = "codeDeploy_attachment"
  roles      = [aws_iam_role.codeDeployRole.name]
  policy_arn = data.aws_iam_policy.managedCodeDeployPolicy.arn

}

resource "aws_codedeploy_app" "codeDeployApp" {
  compute_platform = "Server"
  name             = "test_DeployApp"
}

resource "aws_codedeploy_deployment_group" "codeDeployGroup" {
  app_name              = aws_codedeploy_app.codeDeployApp.name
  deployment_group_name = "test_DeploymentGroup"
  service_role_arn      = aws_iam_role.codeDeployRole.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Grouping"
      value = "testing"
      type  = "KEY_AND_VALUE"
    }
  }

}

data "aws_iam_policy" "managedCodeDeployPolicy" {
  name = "AWSCodeDeployRole"
}