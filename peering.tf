resource "aws_vpc_peering_connection" "deafult-to-roboshop" {
  peer_vpc_id   = var.DEFAULT_VPC_ID
  vpc_id        = aws_vpc.main.id
  auto_accept   = true
}