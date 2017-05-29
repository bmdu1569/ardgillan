############################################################
# This example creates an EFS file system
# and mounts this file system on an EC2 instance
############################################################
# specify AWS as provider
############################################################

provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/Users/bmdu1569/.aws/credentials"
  profile = "hermesnonprod"
}

############################################################
# Create security group in team-hermes-dev-us-east-1-vpc VPC
# Need outbound HTTP for yum update
# Need TCP 2049 to mount NFS4 (efs)
############################################################

resource "aws_security_group" "dashdb" {
  name        = "dash-test"
  description = "test"
  vpc_id      = "vpc-392cc440"
}

resource "aws_security_group_rule" "ssh_in" {
  security_group_id = "${aws_security_group.dashdb.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "tcp_nfs4_in" {
  security_group_id = "${aws_security_group.dashdb.id}"
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "tcp_nfs4_out" {
  security_group_id = "${aws_security_group.dashdb.id}"
  type              = "egress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "tcp_http_out" {
  security_group_id = "${aws_security_group.dashdb.id}"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

############################################################
# Find latest us-east-1 centos AMI
############################################################

data "aws_ami" "centos7" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "product-code.type"
    values = ["marketplace"]
  }

  filter {
    name   = "owner-alias"
    values = ["aws-marketplace"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

############################################################
# Specify team-hermes-dev-public-a  subnet
############################################################

variable "subnet_id" {
  default     = "subnet-57498c7b"
}

############################################################
# Create EFS
############################################################

resource "aws_efs_file_system" "dashdb_mpp_efs" {
  tags {
    Name = "dashdb_mpp"
  }
}

############################################################
# Create mount Target   [team-hermes-dev-public-a  subnet]
############################################################

resource "aws_efs_mount_target" "dashdb_test" {
  file_system_id = "${aws_efs_file_system.dashdb_mpp_efs.id}"
  subnet_id      = "${var.subnet_id}"
  security_groups = ["${aws_security_group.dashdb.id}"]
}

############################################################
# Create AWS instance
############################################################

resource "aws_instance" "dashdb_test" {
  ami = "${data.aws_ami.centos7.id}"
  instance_type = "t2.micro"
  subnet_id = "${var.subnet_id}"
  key_name = "brian.mckeown-aws-key"
  vpc_security_group_ids = ["${aws_security_group.dashdb.id}"]


  ############################################################
  # Increment name each time run 'terraform apply/destroy'
  ############################################################

  tags {
    Name = "dashtst3"
  }

  #############################################################
  # Used own pem key to connect to AWS, install NFS4, mount efs
  #############################################################

  provisioner "remote-exec" {

  connection {
      user = "centos"
      private_key = "${file("/Users/bmdu1569/.ssh/brian.mckeown-aws-key.pem")}"
  }

    inline = [
      "sudo yum update -y",
      "sudo mkdir -p /mnt/efs",
      "sudo chown centos:centos /mnt/efs",
      "sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${aws_efs_file_system.dashdb_mpp_efs.id}.efs.us-east-1.amazonaws.com:/ /mnt/efs",
    ]
  }

}

#############################################################
