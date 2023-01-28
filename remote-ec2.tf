data "terraform_remote_state" "vpc-ssh" {
  backend = "remote"

  config = {
    organization = "FusionIT"
    workspaces = {
      name = "gh-action-demo-eva2"
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
  instance_type = var.instance_type_map["dev"] 
  key_name = var.instance_keypair
  #vpc_security_group_ids = [lookup(data.terraform_remote_state.vpc-ssh.outputs)]
  vpc_security_group_ids = [data.terraform_remote_state.vpc-ssh.outputs.sg_id]
  count = 1
  tags = {
    "Name" = "Staging-${count.index}"
  }
}