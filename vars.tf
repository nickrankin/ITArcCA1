variable "ACCESS_KEY" {}
variable "SECRET_KEY" {}
variable "TOKEN" {}

variable "AMI" {
  type = map(string)
  default = {
    us-east-1 = "ami-0dfcb1ef8550277af"
    us-east-2 = "ami-0cc87e5027adcdca8"
  }
}

variable "REGION" {
  default = "us-east-1"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "KEY_NAME" {
  default = "vockey"
}

variable "TAGS" {
  default = "Demo"
}

variable "COUNT" {
  default = "2"
}