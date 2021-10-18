module "s3" {
  source = "./s3"
  
  region = "${var.region}"
  client = "${var.client}"

}


module "vpc" {
  source = "./vpc"

  vpc_cidr_block = "${var.cidr_block}"
  client         = "${var.client}"
  env            = "${var.env}"
}

module "networks" {
  source = "./networks"
  
  vpc_cidr_block        = "${var.cidr_block}"
  client                = "${var.client}"
  env                   = "${var.env}"
  vpc_id                = "${module.vpc.vpc_id}"
  region                = "${var.region}"
  availability_zone_one = "${var.availability_zone["zone1"]}"
  availability_zone_two = "${var.availability_zone["zone2"]}"
}

module "nat_gateway" {
  source = "./nat_gateway"
  
  eip_one                        = "${module.eip.eip_one}"
  eip_two                        = "${module.eip.eip_two}"
  pub_subnet_one                 = "${module.networks.pub_subnet_one}"
  pub_subnet_two                 = "${module.networks.pub_subnet_two}"
  private_subnet_one             = "${module.networks.private_subnet_one}"
  private_subnet_two             = "${module.networks.private_subnet_two}"
  route_table_private_one        = "${module.networks.route_table_private_one}"
  route_table_private_two        = "${module.networks.route_table_private_two}"
}

module "s_groups" {
  source = "./s_groups"
  
  client = "${var.client}"
  vpc_id = "${module.vpc.vpc_id}"
}

module "eip" {
  source = "./eip"
}

module "elb" {
  source = "./elb"
  
  pub_subnet_one                 = "${module.networks.pub_subnet_one}"
  pub_subnet_two                 = "${module.networks.pub_subnet_two}"
  private_subnet_one             = "${module.networks.private_subnet_one}"
  private_subnet_two             = "${module.networks.private_subnet_two}"
}

module "bastion" {
  source = "./bastion"
  
 
  region                         = "${var.region}"
  bastion_eip                    = "${module.eip.bastion_eip}"
  security_group_id              = "${module.s_groups.security_group_id}"
  iam_role_instance_profile_name = "${module.iam_role.iam_role_instance_profile_name}"
  client                         = "${var.client}"
  aws_access_key                 = "${var.aws_access_key}"
  aws_secret_key                 = "${var.aws_secret_key}"
  vpc_id                         = "${module.vpc.vpc_id}"
  pub_subnet_one                 = "${module.networks.pub_subnet_one}"
  pub_subnet_two                 = "${module.networks.pub_subnet_two}"
  private_subnet_one             = "${module.networks.private_subnet_one}"
  private_subnet_two             = "${module.networks.private_subnet_two}"
  bastion_eip_public_ip          = "${module.eip.public_bastion_eip}"
}