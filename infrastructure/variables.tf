# Replace default with your aws cli username ex.default
variable "cliProfile" {
  type    = string
  default = "default"
}

# Replace with name for tagging ex. bryse.wagner
variable "yourNameTag" {
  type    = string
  default = "bryse.wagner"
}

# name of your key file
variable "keyName" {
  type    = string
  default = "bryseTestKey2"
}

# Added your name -securityGroup is appended to the end of whatever you input
variable "securityGroupName" {
  type    = string
  default = "Bryse"
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