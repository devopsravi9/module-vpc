resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.PROJECT}-${var.ENV}-igw"
  }
}

resource "aws_eip" "ngw" {}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw.id
  subnet_id     = aws_subnet.public.*.id[0]

  tags = {
    Name = "${var.PROJECT}-${var.ENV}-ngw"
  }
}

