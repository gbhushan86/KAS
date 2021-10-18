#NAT-Gateway_1
resource "aws_nat_gateway" "nat_1" {
  allocation_id  = "${var.eip_one}"
  subnet_id      = "${var.pub_subnet_one}"
}

#NAT-Gateway_2
resource "aws_nat_gateway" "nat_2" {
  allocation_id  = "${var.eip_two}"
  subnet_id      = "${var.pub_subnet_two}"
}

resource "aws_route" "route_table_private_one" {
  route_table_id         = "${var.route_table_private_one}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat_1.id}"
}

resource "aws_route_table_association" "route_table_association_private_1" {
  subnet_id      = "${var.private_subnet_one}"
  route_table_id = "${var.route_table_private_one}"
}

resource "aws_route" "route_table_private_two" {
  route_table_id         = "${var.route_table_private_two}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat_2.id}"
}

resource "aws_route_table_association" "route_table_association_private_2" {
  subnet_id      = "${var.private_subnet_two}"
  route_table_id = "${var.route_table_private_two}"
}
