output "private_subnet_one" {
	value = "${aws_subnet.private1.id}"
}

output "private_subnet_two" {
	value = "${aws_subnet.private2.id}"
}

output "pub_subnet_one" {
	value = "${aws_subnet.public1.id}"
}

output "pub_subnet_two" {
	value = "${aws_subnet.public2.id}"
}

output "route_table_private_one" {
	value = "${aws_route_table.route_table_private_1.id}"
}

output "route_table_private_two" {
	value = "${aws_route_table.route_table_private_2.id}"
}



