resource "aws_elb" "try1" {
  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  subnets = ["${var.pub_subnet_one}","${var.private_subnet_two}"]
}

resource "aws_elb" "try2" {
  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  subnets = ["${var.pub_subnet_two}","${var.private_subnet_one}"]
}