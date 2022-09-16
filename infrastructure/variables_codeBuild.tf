variable "artifactBucket" {
  type    = string
  default = "cr6-s3-smittys"
}

variable "codeBuildLogGroupvar" {
  type    = string
  default = "CR6-Smittys-LogGroup"
}

variable "codeBuildProjectName" {
  type    = string
  default = "CR6-Smittys-CBProject"
}

variable "repoURL" {
  type    = string
  default = "https://github.com/dagmawi17/cr-sprint6-TheSmittys.git"
}