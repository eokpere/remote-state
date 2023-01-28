variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "ca-central-1"
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
  type = string
  default = "mykeypair"
}

# AWS EC2 Instance Type - Map
variable "instance_type_map" {
  description = "EC2 Instance Type"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "qa" = "t3.small"
    "prod" = "t3.large"
  }
}
