resource "aws_subnet" "public" {
  count             = length(var.PUBLIC_CIDR)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.PUBLIC_CIDR[count.index]
  availability_zone = var.AZ[count.index]
tags = {
    Name            = "${var.PROJECT}-${var.ENV}-public-subnet"
  }
}

resource "aws_subnet" "private" {
  count              = length(var.PRIVATE_CIDR)
  vpc_id             = aws_vpc.main.id
  cidr_block         = var.PRIVATE_CIDR[count.index]
  availability_zone = var.AZ[count.index]
  tags = {
    Name             = "${var.PROJECT}-${var.ENV}-private-subnet"
  }
}