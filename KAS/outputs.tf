output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_cidr" {
  value = "${module.vpc.vpc_cidr}"
}

output "sg_id" {
  value = "${module.s_groups.security_group_id}"
}

output "subnet_id" {
  value = "${module.networks.pub_subnet_one}"
}

output "bastion_ip" {
  value = "${module.eip.public_bastion_eip}"
} 

