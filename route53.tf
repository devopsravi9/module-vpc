resource "aws_route53_zone_association" "secondary" {
  zone_id = "Z04748881QTGM14CJWM7A"
  vpc_id  = aws_vpc.main.id
}