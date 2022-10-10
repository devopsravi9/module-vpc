resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags   = {
    Name = "${var.PROJECT}-${var.ENV}-public-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id  = aws_vpc.main.id

  tags    = {
    Name  = "${var.PROJECT}-${var.ENV}-private-rt"
  }
}

resource "aws_route_table_association" "public" {
  count                     = length(aws_subnet.public)
  subnet_id                 = aws_subnet.public.*.id[count.index]
  route_table_id            = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count                     = length(aws_subnet.private)
  subnet_id                 = aws_subnet.private.*.id[count.index]
  route_table_id            = aws_route_table.private.id
}

resource "aws_route" "igw-route-to-public-subnet" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.igw.id
}

resource "aws_route" "ngw-route-to-private-subnet" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.ngw.id
}

resource "aws_route" "default-to-roboshop" {
  route_table_id            = var.DEFAULT_ROUTE_TABLE_ID
  destination_cidr_block    = var.VPC_CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.deafult-to-roboshop.id
}

resource "aws_route" "public-subnet-to-default" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = var.DEFAULT_CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.deafult-to-roboshop.id
}

resource "aws_route" "private-subnet-to-default" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = var.DEFAULT_CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.deafult-to-roboshop.id
}

