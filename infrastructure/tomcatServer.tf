resource "aws_instance" "tomcat_server1" {
  # We will want to fix this later so it is not hardcoded
  instance_type        = "t2.micro"
  ami                  = data.aws_ami.latestUbuntu.id
  key_name             = var.keyName
  iam_instance_profile = aws_iam_instance_profile.ec2_appServer_profile.name

  tags = {
    Name     = "AppServer1",
    Grouping = "testing"

  }
  # need to create a security group
  security_groups = ["${var.securityGroupName}-securityGroup"]
  user_data       = file(var.tomcatData)
}

resource "aws_instance" "tomcat_server2" {
  # We will want to fix this later so it is not hardcoded
  instance_type        = "t2.micro"
  ami                  = data.aws_ami.latestUbuntu.id
  key_name             = var.keyName
  iam_instance_profile = aws_iam_instance_profile.ec2_appServer_profile.name

  tags = {
    Name     = "AppServer2",
    Grouping = "testing"

  }
  # need to create a security group
  security_groups = ["${var.securityGroupName}-securityGroup"]
  user_data       = file(var.tomcatData)
}


resource "aws_iam_role" "appServerRole" {
  name = "ec2_appServer_Role"

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

resource "aws_iam_policy_attachment" "appServerPolicyAttachment" {

  name       = "appServer_ec2_attachment"
  roles      = [aws_iam_role.appServerRole.name]
  policy_arn = aws_iam_policy.appServerPolicy.arn

}

resource "aws_iam_instance_profile" "ec2_appServer_profile" {

  name = "appServer_profile"
  role = aws_iam_role.appServerRole.name

}

resource "aws_iam_policy" "appServerPolicy" {

  name = "ec2_appServer_policy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": "*"
        }
    ]
}
POLICY

}