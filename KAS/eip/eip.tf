#EIP_1
resource "aws_eip" "nat_1" {
  vpc = true
}

#EIP_2
resource "aws_eip" "nat_2" {
  vpc = true
}

#Bastion EIP
resource "aws_eip" "bastion_eip" {
  vpc = true
}
