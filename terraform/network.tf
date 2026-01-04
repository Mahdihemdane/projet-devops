# Utilisation du VPC par défaut (Lab restriction)
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# Utilisation d'un subnet par défaut
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
}

# On prend le premier subnet disponible
data "aws_subnet" "default" {
  id = data.aws_subnets.default.ids[0]
}
