#PUBLIC-SUBNET_1
resource "aws_subnet" "public1" {
  #depends_on        = ["aws_vpc.main"]
  cidr_block        = "${cidrsubnet(var.vpc_cidr_block, 2, 0)}"
  vpc_id            = "${var.vpc_id}"
  availability_zone = "${var.region}${var.availability_zone_one}"

  tags {
    Name              = "${var.client}-zone1-${var.availability_zone_one}"
    KubernetesCluster = "${var.env}.${var.client}"
      }
}

#PUBLIC-SUBNET_2
resource "aws_subnet" "public2" {
  #depends_on        = ["aws_vpc.main"]
  cidr_block        = "${cidrsubnet(var.vpc_cidr_block, 2, 1)}"
  vpc_id            = "${var.vpc_id}"
  availability_zone = "${var.region}${var.availability_zone_two}"

  tags {
    Name              = "${var.client}-zone2-${var.availability_zone_two}"
    KubernetesCluster = "${var.env}.${var.client}"
      }
}

#PRIVATE-SUBNET_1
resource "aws_subnet" "private1" {
  #depends_on        = ["aws_vpc.main"]
  cidr_block        = "${cidrsubnet(var.vpc_cidr_block, 2, 2)}"
  vpc_id            = "${var.vpc_id}"
  availability_zone = "${var.region}${var.availability_zone_one}"
  tags {
    Name              = "${var.client}-zone1-private1-${var.availability_zone_one}"
    KubernetesCluster = "${var.env}.${var.client}"
      }
}

#PRIVATE-SUBNET_2
resource "aws_subnet" "private2" {
  #depends_on        = ["aws_vpc.main"]
  cidr_block        = "${cidrsubnet(var.vpc_cidr_block, 2, 3)}"
  vpc_id            = "${var.vpc_id}"
  availability_zone = "${var.region}${var.availability_zone_two}"
  tags {
    Name              = "${var.client}-zone2-private2-${var.availability_zone_two}"
    KubernetesCluster = "${var.env}.${var.client}"
      }
}


#Internet-Gateway
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.client}-Internet-Gateway"
  }
}

#PUBLIC-ROUTETABLE
resource "aws_route_table" "route_table_public" {
  vpc_id     = "${var.vpc_id}"

  tags {
    Name = "${var.client}-route-table-public"
    }
}
resource "aws_route" "route_table_public" {
  route_table_id         = "${aws_route_table.route_table_public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gw.id}"
}
resource "aws_route_table_association" "route_table_association_public_1" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.route_table_public.id}"
}
resource "aws_route_table_association" "route_table_association_public_2" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.route_table_public.id}"
}

resource "aws_main_route_table_association" "route_table_main" {
  vpc_id         = "${var.vpc_id}"
  route_table_id = "${aws_route_table.route_table_public.id}"
}

#PRIVATE-ROUTETABLE_1
resource "aws_route_table" "route_table_private_1" {
  vpc_id = "${var.vpc_id}"

  tags {
      Name = "${var.client}-route-table-private_1"
    }
}

#PRIVATE-ROUTETABLE_2
resource "aws_route_table" "route_table_private_2" {
  vpc_id = "${var.vpc_id}"

  tags {
      Name = "${var.client}-route-table-private_2"
    }
}

resource "aws_flow_log" "clove_flowlogs" {
  iam_role_arn    = "${aws_iam_role.clove_flowlogs.arn}"
  log_destination = "${aws_cloudwatch_log_group.clove_flowlogs.arn}"
  traffic_type    = "ALL"
  vpc_id          = "${var.vpc_id}"
}

resource "aws_cloudwatch_log_group" "clove_flowlogs" {
  name = "${var.client}.clove_flowlogs"
}

resource "aws_iam_role" "clove_flowlogs" {
  name = "${var.client}.clove_flowlogs"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "clove_flowlogs" {
  name = "${var.client}.clove_flowlogs"
  role = "${aws_iam_role.clove_flowlogs.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
