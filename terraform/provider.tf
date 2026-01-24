variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_session_token" {}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
}
