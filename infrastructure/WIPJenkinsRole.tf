resource "aws_iam_role" "jenkinsRole" {
  name = "ec_jenkisn_Role"

  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
            }
        ]
    }
    EOF
}

resource "aws_iam_policy_attachment" "jenkinsPolicyAttachment" {

  name       = "jenkins_ec2_attachment"
  roles      = [aws_iam_role.jenkinsRole.name]
  policy_arn = aws_iam_policy.jenkinsPolicy.arn

}

resource "aws_iam_instance_profile" "ec2_jenkins_profile" {

  name = "ec2_profile"
  role = aws_iam_role.jenkinsRole.name

}

resource "aws_iam_policy" "jenkinsPolicy" {

  name = "ec2_jenkins_policy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:TerminateInstances",
                "ec2:RequestSpotInstances",
                "ec2:DeleteTags",
                "ec2:CreateTags",
                "ec2:DescribeRegions",
                "ec2:RunInstances",
                "ec2:DescribeSpotInstanceRequests",
                "ec2:StopInstances",
                "ec2:DescribeSecurityGroups",
                "ec2:GetConsoleOutput",
                "ec2:DescribeImages",
                "ec2:CancelSpotInstanceRequests",
                "iam:ListInstanceProfilesForRole",
                "ec2:GetPasswordData",
                "iam:PassRole",
                "ec2:StartInstances",
                "ec2:DescribeAvailabilityZones",
                "ec2:DescribeInstanceTypes",
                "codebuild:ListProjects",
                "ec2:DescribeSubnets",
                "ec2:DescribeKeyPairs",
                "codebuild:*"
            ],
            "Resource": "*"
        },
        {
            "Action": [
            "codedeploy:Batch*",
            "codedeploy:CreateDeployment",
            "codedeploy:Get*",
            "codedeploy:List*",
            "codedeploy:RegisterApplicationRevision"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
POLICY

}