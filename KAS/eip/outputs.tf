output "eip_one" {
	value = "${aws_eip.nat_1.id}"
}

output "eip_two" {
	value = "${aws_eip.nat_2.id}"
}

output "bastion_eip" {
  value = "${aws_eip.bastion_eip.id}"
}

output "public_bastion_eip" {
  value = "${aws_eip.bastion_eip.public_ip}"
}

