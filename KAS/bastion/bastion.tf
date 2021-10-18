resource "aws_instance" "bastion" {
  ami                    = "${var.bastion_ami}"
  instance_type          = "${var.bastion["instance_type"]}"
  key_name               = "${aws_key_pair.ethankey.key_name}"
  subnet_id              = "${var.pub_subnet_one}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${var.security_group_id}"]




  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.bastion["volume_size"]}"
  }
  
  tags {
    Name             = "${var.client}-bastion"
    customer         = "${var.client}"
    Service          = "${var.bastion["Service"]}"
    ServiceComponent = "${var.bastion["ServiceComponent"]}"
    NetworkTier      = "${var.bastion["NetworkTier"]}"
  }
}

resource "aws_eip_association" "eip_bastion" {
  instance_id = "${aws_instance.bastion.id}"
  allocation_id = "${var.bastion_eip}"
  

   connection {
    host         = "${var.bastion_eip_public_ip}"
    type         = "ssh"
    user         = "ubuntu"
    private_key  = "${file("${var.private_key}")}"
  }
 }
}
