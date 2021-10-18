variable "bastion_ami" { 
  default = "###B_AMI###"
}

variable "WorkerNode_ami" {
  default = "###WN_AMI###"
}

variable "bastion_eip" { }

variable "region" { }

variable "pub_subnet_one" { }

variable "pub_subnet_two" { }

variable "private_subnet_one" { }

variable "private_subnet_two" { }

variable "security_group_id" { }

variable "iam_role_instance_profile_name" { }

variable "client" { }

variable "aws_access_key" { }

variable "aws_secret_key" { }

variable "vpc_id" { }

variable "cartridge_list" {
  default = "###CARTRIDGE###"
}

variable "innersource_password" { }

variable "innersource_username" { }

variable "docker_username" { }

variable "docker_password" { }

variable "node_type" {
  default = "###NODE_TYPE###"
}

resource "aws_key_pair" "ethankey" {
  key_name   = "${var.client}-key"
  public_key = "${file("./ssh_key/###SSH_KEY_NAME###.pub")}"
}

variable "private_key" {
  default = "./ssh_key/###SSH_KEY_NAME###"
}

variable "pub_key" {
  default = "./ssh_key/###SSH_KEY_NAME###.pub"
}

variable "bastion" {
  default = {
    volume_size   = 20
    instance_type = "t2.micro"
    Service = "Bastion"
    ServiceComponent = "Bastion"
    NetworkTier = "Public"
  }
}

variable "node_count" {
  default = "###NODE_COUNT###"
}

variable "tools_list" {
  default = "###TOOLS###"
}

variable "tool_details" {
  type = "string"
  default = "###TOOL_DETAILS###"
}

variable "graphql_jwt_uname" { }

variable "graphql_jwt_pass" { }

variable "graphql_jwtSecret" { }

variable "cartridge_details" {
  type = "string"
  default = "###CARTRIDGE_DETAILS###"
}

variable "service_role_arn" { }

variable "node_group_arn" { }

variable "node_group_instance_profile_arn" { }

variable "bastion_eip_public_ip" { }