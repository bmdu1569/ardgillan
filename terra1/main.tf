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

resource "aws_security_group_rule" "tcp_https_out" {
  security_group_id = "${aws_security_group.dashdb.id}"
  type              = "egress"
  from_port         = 443
  to_port           = 443
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
# Create AWS instance  (depends on EFS mount point available)
############################################################

variable "instance_count" {
  description = "Number of dashdb nodes"
  default     = "3"
}

resource "aws_instance" "dashdb_test" {
  depends_on = ["aws_efs_mount_target.dashdb_test"]
  ami = "${data.aws_ami.centos7.id}"
  instance_type = "t2.micro"
  count = "${var.instance_count}"
  subnet_id = "${var.subnet_id}"
  key_name = "brian.mckeown-aws-key"
  vpc_security_group_ids = ["${aws_security_group.dashdb.id}"]


  ############################################################
  # Increment name each time run 'terraform apply/destroy'
  ############################################################

  tags {
    Name = "bmck-dash-a-${count.index}"
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
      "sudo mkdir -p /mnt/clusterfs",
      "sudo chown centos:centos /mnt/clusterfs",
      "sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${aws_efs_file_system.dashdb_mpp_efs.id}.efs.us-east-1.amazonaws.com:/ /mnt/clusterfs",
      "sudo chown centos:centos /etc/sysctl.conf",
      "sudo echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf",
      "sudo systemctl restart network"
    ]
  }

}

#############################################################
# Create nodes file on EFS according to required format
#############################################################

variable "dash_node_name" {
  description = "List of node names"
  type = "list"
  default = ["head_node", "data_node1", "data_node2"]
}

resource "null_resource" "dashdb_create_hosts" {
  depends_on          = ["aws_instance.dashdb_test"]
  count               = "${var.instance_count}"

  provisioner "remote-exec" {

    connection {
        host = "${element(aws_instance.dashdb_test.*.public_ip, count.index)}"
        user = "centos"
        private_key = "${file("/Users/bmdu1569/.ssh/brian.mckeown-aws-key.pem")}"
    }

    inline = [
        "sudo chown centos:centos /mnt/clusterfs",
        "sudo echo ${element(var.dash_node_name, count.index)}=${element(aws_instance.dashdb_test.*.private_dns, count.index)}:${element(aws_instance.dashdb_test.*.private_ip, count.index)} >> /mnt/clusterfs/nodes",
        #"sudo echo -n $(hostname -s) >> /mnt/clusterfs/nodes",
        #"sudo echo -n :$(ifconfig | grep 'inet ' | grep 10.0 | awk '{print $2}') >> /mnt/clusterfs/nodes"
        "sudo yum install -y docker",
        "sudo service docker start",
        "sudo docker login -u=bmckeown16 -p='euro2016'",
        "sudo docker pull ibmdashdb/local:latest-linux",
        "sudo docker run -d -it --privileged=true --net=host --name=dashDB -v /mnt/clusterfs:/mnt/bludata0 -v /mnt/clusterfs:/mnt/blumeta0 ibmdashdb/local:latest-linux"
    ]
  }
}

#############################################################

output "private_ips" {
  value = ["${aws_instance.dashdb_test.*.private_ip}"]
}

output "public_ips" {
  value = ["${aws_instance.dashdb_test.*.public_ip}"]
}

output "dashdb_public_hostnames"{
  value = ["${aws_instance.dashdb_test.*.public_dns}"]
}

output "dashdb_private_hostnames"{
  value = ["${aws_instance.dashdb_test.*.private_dns}"]
}
