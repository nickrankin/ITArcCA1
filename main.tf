## EC2 Instances
resource "aws_instance" "server" {
  ami = lookup(var.AMI, var.REGION)
  instance_type = var.INSTANCE_TYPE
  key_name = var.KEY_NAME

  tags = {
	  Name = var.SERVER_TAGS
  }

  user_data = "${file("./startScript.sh")}"

  vpc_security_group_ids  = [ aws_security_group.server_security_group.id ]
  associate_public_ip_address = true

  // https://stackoverflow.com/questions/59878003/how-do-i-assign-random-subnet-id-into-azurerm-network-interface
  subnet_id = element(module.vpc.public_subnets.*, count.index)

  count = var.COUNT
}

## Load Balancer https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "server_load_balancer" {
  name               = var.LOAD_BALANCER_NAME
  internal           = false
  load_balancer_type = "network"
  subnets            = [for subnet in module.vpc.public_subnets : subnet]

  enable_deletion_protection = false

  tags = {
    Environment = var.LOAD_BALANCER_TAG
  }
}

## Security Group
resource aws_security_group "server_security_group" {
    name = var.SERVER_SECURITY_GROUP_NAME
    description = var.SERVER_SECURITY_GROUP_DESC
    tags = {
      Name = var.SERVER_SECURITY_GROUP_TAGS
    }

    vpc_id =  module.vpc.vpc_id 

  ingress {
    from_port = var.SSH_PORT
    to_port = var.SSH_PORT
    protocol = var.PROTOCOL_TCP
    cidr_blocks = [var.IP_RANGE]
  }
  
  ingress {
    from_port = var.HTTP_PORT
    to_port = var.HTTP_PORT
    protocol = var.PROTOCOL_TCP
    cidr_blocks = [var.IP_RANGE]
  }

  ingress {
    from_port = var.TOMCAT_HTTP_PORT
    to_port = var.TOMCAT_HTTP_PORT
    protocol = var.PROTOCOL_TCP
    cidr_blocks = [var.IP_RANGE]
  }
  
  
  ingress {
    from_port = var.HTTPS_PORT
    to_port = var.HTTPS_PORT
    protocol = var.PROTOCOL_TCP
    cidr_blocks = [var.IP_RANGE]
  }
  
  egress {
    from_port = var.SSH_PORT
    to_port = var.SSH_PORT
    protocol = var.PROTOCOL_TCP
    cidr_blocks = [var.IP_RANGE]
  }
  
  egress {
    from_port = var.HTTP_PORT
    to_port = var.HTTP_PORT
    protocol = var.PROTOCOL_TCP
    cidr_blocks = [var.IP_RANGE]
  }

  egress {
    from_port = var.TOMCAT_HTTP_PORT
    to_port = var.TOMCAT_HTTP_PORT
    protocol = var.PROTOCOL_TCP
    cidr_blocks = [var.IP_RANGE]
  }  
  egress {
    from_port = var.HTTPS_PORT
    to_port = var.HTTPS_PORT
    protocol = var.PROTOCOL_TCP
    cidr_blocks = [var.IP_RANGE]
  }
}

## Example to hook up a ElastiCache instance based on Redis
# resource "aws_elasticache_cluster" "example" {
#   cluster_id           = "cluster-example"
#   engine               = "redis"
#   node_type            = "cache.m4.large"
#   num_cache_nodes      = 1
#   parameter_group_name = "default.redis3.2"
#   engine_version       = "3.2.10"
#   port                 = 6379
# }

## Example to spin up a AWS DB Instance
# resource "aws_db_instance" "db" {
#   allocated_storage    = var.DB_STORAGE
#   db_name              = var.DB_NAME
#   engine               = var.DB_TYPE
#   engine_version       = var.MYSQL_ENGINE_VERSION
#   instance_class       = var.DB_INSTANCE_TYPE
#   username             = var.DB_NAME
#   password             = var.DB_PASSWORD
#   skip_final_snapshot  = true
# }

# resource aws_security_group "RDS_security_group" {
#     name = var.RDS_SECURITY_GROUP_NAME
#     description = var.RDS_SECURITY_GROUP_DESC
#     tags = {
#       Name = var.RDS_SECURITY_GROUP_TAGS
#     }
# }

# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest?tab=outputs
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}