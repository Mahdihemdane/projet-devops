data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Lab restriction: Cannot create key pairs
# resource "aws_key_pair" "k8s_key" {
#   key_name   = "k8s-key"
#   public_key = file("${path.module}/../keys/k8s-key.pub")
# }

resource "aws_instance" "master" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  subnet_id     = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  # key_name removed due to Lab restrictions

  root_block_device {
    volume_size = 16
  }

  tags = {
    Name = "k8s-master"
    Role = "master"
  }
}

resource "aws_instance" "worker" {
  count         = 2
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  subnet_id     = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  # key_name removed due to Lab restrictions

  root_block_device {
    volume_size = 16
  }

  tags = {
    Name = "k8s-worker-${count.index + 1}"
    Role = "worker"
  }
}
