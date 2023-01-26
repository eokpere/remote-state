data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "FusionIT"
    workspaces = {
      name = "gh-action-demo-eva"
    }
  }
}

/*
# Terraform >= 0.12
resource "aws_instance" "foo" {
  # ...
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
}

# Terraform <= 0.11
resource "aws_instance" "foo" {
  # ...
  subnet_id = "${data.terraform_remote_state.vpc.subnet_id}"
}
*/

resource "aws_instance" "my-ec2" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = "t2.micro" 
  key_name = "mykeypair"
  aws_security_group_id = data.terraform_remote_state.aws_security_group.vpc-ssh.id
  count = 1
  tags = {
    "Name" = "Staging-${count.index}"
  }
}