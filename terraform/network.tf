data "aws_vpc" "lab_vpc" {
  id = "vpc-024b258784b00a2c3"
}

data "aws_subnets" "lab_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.lab_vpc.id]
  }
}

data "aws_subnet" "lab_subnet" {
  id = data.aws_subnets.lab_subnets.ids[0]
}
