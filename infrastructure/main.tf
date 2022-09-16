
# provider stuff, make sure you're logged into the cli
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region  = var.targetRegion
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
  name = "${var.securityGroupName}-SG"
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    # variable of our ip addresses
    cidr_blocks = var.allowed_cidr_blocks
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
  ami           = data.aws_ami.latestUbuntu.id
  key_name      = var.keyName

  tags = {
    Name = var.ec2Name
  }
  # need to create a security group
  security_groups = ["${var.securityGroupName}-SG"]
#   user_data = <<EOF
#   #! /bin/bash

#   sudo apt install openjdk-11-jdk -y

#   sudo apt-get update -y

#   sudo apt install jenkins -y

#   sudo sudo systemctl start jenkins

#   EOF
}

# Data source to get the latest LTS ami for Ubuntu 
data "aws_ami" "latestUbuntu" {

  most_recent = true
  owners      = ["099720109477"]

  filter {

    name   = "virtualization-type"
    values = ["hvm"]

  }

  filter {

    name   = "root-device-type"
    values = ["ebs"]

  }

  filter {

    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]

  }

}

