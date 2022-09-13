
# provider stuff, make sure you're logged into the cli
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region  = "us-east-2"
  profile = var.cliProfile
}

# used to generate our key pair
resource "tls_private_key" "generateKey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# put public key into aws to be used for ssh
resource "aws_key_pair" "awsKeyPair" {
  key_name   = var.keyName
  public_key = tls_private_key.generateKey.public_key_openssh
}

# download our .pem file
resource "local_file" "downloadKey" {
  filename = "${aws_key_pair.awsKeyPair.key_name}.pem"
  content  = tls_private_key.generateKey.private_key_pem
}

resource "aws_security_group" "securityGroup" {
  name = "${var.securityGroupName}-securityGroup"
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    # variable of our ip address
    cidr_blocks = ["${var.ipAddress}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# our ec2 instance to host jenkins
resource "aws_instance" "jenkins_server" {
  # We will want to fix this later so it is not hardcoded
  instance_type = "t2.micro"
  ami           = "ami-02f3416038bdb17fb"
  key_name      = var.keyName

  tags = {
    Name = var.yourNameTag
  }
  # need to create a security group
  security_groups = ["${var.securityGroupName}-securityGroup"]
  #user_data = file(var.fileName)
}



