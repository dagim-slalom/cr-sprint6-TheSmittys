# Replace default with your aws cli username ex.default
variable "cliProfile" {
  type    = string
  default = "default"
}

# Replace to what you want your ec2 instance to be named
variable "ec2Name" {
  type    = string
  default = "sprint6-cr-theSmittys-jenkinsServer"
}

# name of your key file
variable "keyName" {
  type    = string
  default = "theSmittysKey"
}

# Added your name -securityGroup is appended to the end of whatever you input
variable "securityGroupName" {
  type    = string
  default = "theSmittys"
}

#input your ip address so that you can ssh into the ec2 insance
variable "ipAddress" {
  type    = string
  default = "184.57.36.105/32"
}
# input name of your userdatafile
variable "userData" {
  type    = string
  default = "TestfileName"
}