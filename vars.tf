variable "ACCESS_KEY" {}
variable "SECRET_KEY" {}
variable "TOKEN" {}

variable "AMI" {
  type = map(string)
  default = {
    us-east-1 = "ami-0c7217cdde317cfec"
    us-east-2 = "ami-0c7217cdde317cfec"
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

variable "SERVER_TAGS" {
  default = "CA1_instance"
}

variable "MANAGEMENT_SERVER_NAME" {
  default="CA1 Management Instance"
}

variable "COUNT" {
  default = "3"
}

variable SERVER_SECURITY_GROUP_NAME {
  default = "gv-security-group"
}

variable SERVER_SECURITY_GROUP_DESC {
  default = "Enable HTTP & SSH Access to instance"
}

variable "SERVER_SECURITY_GROUP_TAGS" {
  default = "Server"
}

variable PROTOCOL_TCP {
  default = "tcp"
}

variable "SSH_PORT" {
  default = "22"
}

variable "HTTP_PORT" {
  default = "80"
}

variable "TOMCAT_HTTP_PORT" {
  default = "8080"
}

variable "HTTPS_PORT" {
  default = "443"
}

variable "IP_RANGE" {
  default = "0.0.0.0/0"
}

variable "DB_NAME" {
  default = "revenue_db"
}

variable DB_TYPE {
  default = "mysql"
}

variable DB_STORAGE {
  default = 10
}

variable MYSQL_ENGINE_VERSION {
  default = 5.7
}

variable DB_INSTANCE_TYPE {
  default = "db.t3.micro"
}

variable DB_USER {
  default = "nickdba"
}

variable DB_PASSWORD {
  default = "PaSSwOrd1!~"
}

variable RDS_SECURITY_GROUP_NAME {
  default = "db_security_group"
}

variable RDS_SECURITY_GROUP_DESC {
  default = "Enable MySQL and EC2 comms"
}

variable RDS_SECURITY_GROUP_TAGS {
  default = "db security group"
}

variable LOAD_BALANCER_NAME {
  default = "LB"
}

variable LOAD_BALANCER_TAG {
  default = "Load Balancer for CA1"
}