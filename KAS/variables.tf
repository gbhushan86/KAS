provider "aws" {
  region = "${var.region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

variable "aws_access_key" { }

variable "aws_secret_key" { }

variable "innersource_username" { }

variable "innersource_password" { }

variable "docker_username" { }

variable "docker_password" { }

variable "graphql_jwt_uname" { }

variable "graphql_jwt_pass" { }

variable "graphql_jwtSecret" { }

variable "client" { }

variable "env" {
  default = "devops"
}


variable "cidr_block" {
        default = "11.2.0.0/16"
}

variable "region" { }

variable "availability_zone" {
  default = {
    zone1 = "a"
    zone2 = "b"
  }
}

