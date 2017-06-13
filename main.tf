#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-a4f9f2c2
#
# Your subnet ID is:
#
#     subnet-7aba681d
#
# Your security group ID is:
#
#     sg-00100979
#
# Your Identity is:
#
#     hdays-michel-viper
#

variable aws_access_key {}

variable aws_secret_key {}

variable aws_region {
  default = "eu-west-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

variable web_nums {
  default = "2"
}

resource "aws_instance" "web" {
  # ...
  ami                    = "ami-a4f9f2c2"
  instance_type          = "t2.micro"
  count                  = "3"
  subnet_id              = "subnet-7aba681d"
  vpc_security_group_ids = ["sg-00100979"]

  tags {
    Identity         = "hdays-michael-viper"
    TerraformVersion = "0.9.5"

    #Name = "web ${count.index}/${max(count.index)+1}"

    Name = "web ${count.index+1}/${var.web_nums}"
    Date = "20170613"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

terraform {
  backend "atlas" {
    name = "aronneagu/training"
  }
}
