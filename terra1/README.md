brians-mbp:terra1 bmdu1569$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.aws_ami.centos7: Refreshing state...
The Terraform execution plan has been generated and is shown below.
Resources are shown in alphabetical order for quick scanning. Green resources
will be created (or destroyed and then created if an existing resource
exists), yellow resources are being changed in-place, and red resources
will be destroyed. Cyan entries are data sources to be read.

Note: You didn't specify an "-out" parameter to save this plan, so when
"apply" is called, Terraform can't guarantee this is what will execute.

+ aws_efs_file_system.dashdb_mpp_efs
    creation_token:   "<computed>"
    performance_mode: "<computed>"
    reference_name:   "<computed>"
    tags.%:           "1"
    tags.Name:        "dashdb_mpp"

+ aws_efs_mount_target.dashdb_test
    dns_name:             "<computed>"
    file_system_id:       "${aws_efs_file_system.dashdb_mpp_efs.id}"
    ip_address:           "<computed>"
    network_interface_id: "<computed>"
    security_groups.#:    "<computed>"
    subnet_id:            "subnet-57498c7b"

+ aws_instance.dashdb_test
    ami:                          "ami-46c1b650"
    associate_public_ip_address:  "<computed>"
    availability_zone:            "<computed>"
    ebs_block_device.#:           "<computed>"
    ephemeral_block_device.#:     "<computed>"
    instance_state:               "<computed>"
    instance_type:                "t2.micro"
    ipv6_address_count:           "<computed>"
    ipv6_addresses.#:             "<computed>"
    key_name:                     "brian.mckeown-aws-key"
    network_interface.#:          "<computed>"
    network_interface_id:         "<computed>"
    placement_group:              "<computed>"
    primary_network_interface_id: "<computed>"
    private_dns:                  "<computed>"
    private_ip:                   "<computed>"
    public_dns:                   "<computed>"
    public_ip:                    "<computed>"
    root_block_device.#:          "<computed>"
    security_groups.#:            "<computed>"
    source_dest_check:            "true"
    subnet_id:                    "subnet-57498c7b"
    tags.%:                       "1"
    tags.Name:                    "dashtst3"
    tenancy:                      "<computed>"
    volume_tags.%:                "<computed>"
    vpc_security_group_ids.#:     "<computed>"

+ aws_security_group.dashdb
    description: "test"
    egress.#:    "<computed>"
    ingress.#:   "<computed>"
    name:        "dash-test"
    owner_id:    "<computed>"
    vpc_id:      "vpc-392cc440"

+ aws_security_group_rule.ssh_in
    cidr_blocks.#:            "1"
    cidr_blocks.0:            "0.0.0.0/0"
    from_port:                "22"
    protocol:                 "tcp"
    security_group_id:        "${aws_security_group.dashdb.id}"
    self:                     "false"
    source_security_group_id: "<computed>"
    to_port:                  "22"
    type:                     "ingress"

+ aws_security_group_rule.tcp_http_out
    cidr_blocks.#:            "1"
    cidr_blocks.0:            "0.0.0.0/0"
    from_port:                "80"
    protocol:                 "tcp"
    security_group_id:        "${aws_security_group.dashdb.id}"
    self:                     "false"
    source_security_group_id: "<computed>"
    to_port:                  "80"
    type:                     "egress"

+ aws_security_group_rule.tcp_nfs4_in
    cidr_blocks.#:            "1"
    cidr_blocks.0:            "0.0.0.0/0"
    from_port:                "2049"
    protocol:                 "tcp"
    security_group_id:        "${aws_security_group.dashdb.id}"
    self:                     "false"
    source_security_group_id: "<computed>"
    to_port:                  "2049"
    type:                     "ingress"

+ aws_security_group_rule.tcp_nfs4_out
    cidr_blocks.#:            "1"
    cidr_blocks.0:            "0.0.0.0/0"
    from_port:                "2049"
    protocol:                 "tcp"
    security_group_id:        "${aws_security_group.dashdb.id}"
    self:                     "false"
    source_security_group_id: "<computed>"
    to_port:                  "2049"
    type:                     "egress"


Plan: 8 to add, 0 to change, 0 to destroy.
brians-mbp:terra1 bmdu1569$ terraform apply
data.aws_ami.centos7: Refreshing state...
aws_security_group.dashdb: Creating...
  description: "" => "test"
  egress.#:    "" => "<computed>"
  ingress.#:   "" => "<computed>"
  name:        "" => "dash-test"
  owner_id:    "" => "<computed>"
  vpc_id:      "" => "vpc-392cc440"
aws_efs_file_system.dashdb_mpp_efs: Creating...
  creation_token:   "" => "<computed>"
  performance_mode: "" => "<computed>"
  reference_name:   "" => "<computed>"
  tags.%:           "" => "1"
  tags.Name:        "" => "dashdb_mpp"
aws_security_group.dashdb: Creation complete (ID: sg-6b370215)
aws_security_group_rule.ssh_in: Creating...
  cidr_blocks.#:            "" => "1"
  cidr_blocks.0:            "" => "0.0.0.0/0"
  from_port:                "" => "22"
  protocol:                 "" => "tcp"
  security_group_id:        "" => "sg-6b370215"
  self:                     "" => "false"
  source_security_group_id: "" => "<computed>"
  to_port:                  "" => "22"
  type:                     "" => "ingress"
aws_security_group_rule.tcp_nfs4_out: Creating...
  cidr_blocks.#:            "" => "1"
  cidr_blocks.0:            "" => "0.0.0.0/0"
  from_port:                "" => "2049"
  protocol:                 "" => "tcp"
  security_group_id:        "" => "sg-6b370215"
  self:                     "" => "false"
  source_security_group_id: "" => "<computed>"
  to_port:                  "" => "2049"
  type:                     "" => "egress"
aws_security_group_rule.tcp_nfs4_in: Creating...
  cidr_blocks.#:            "" => "1"
  cidr_blocks.0:            "" => "0.0.0.0/0"
  from_port:                "" => "2049"
  protocol:                 "" => "tcp"
  security_group_id:        "" => "sg-6b370215"
  self:                     "" => "false"
  source_security_group_id: "" => "<computed>"
  to_port:                  "" => "2049"
  type:                     "" => "ingress"
aws_security_group_rule.tcp_http_out: Creating...
  cidr_blocks.#:            "" => "1"
  cidr_blocks.0:            "" => "0.0.0.0/0"
  from_port:                "" => "80"
  protocol:                 "" => "tcp"
  security_group_id:        "" => "sg-6b370215"
  self:                     "" => "false"
  source_security_group_id: "" => "<computed>"
  to_port:                  "" => "80"
  type:                     "" => "egress"
aws_security_group_rule.ssh_in: Creation complete (ID: sgrule-4076980519)
aws_security_group_rule.tcp_nfs4_out: Creation complete (ID: sgrule-969987189)
aws_security_group_rule.tcp_nfs4_in: Creation complete (ID: sgrule-2723444275)
aws_efs_file_system.dashdb_mpp_efs: Creation complete (ID: fs-99e561d0)
aws_efs_mount_target.dashdb_test: Creating...
  dns_name:                   "" => "<computed>"
  file_system_id:             "" => "fs-99e561d0"
  ip_address:                 "" => "<computed>"
  network_interface_id:       "" => "<computed>"
  security_groups.#:          "" => "1"
  security_groups.3314344846: "" => "sg-6b370215"
  subnet_id:                  "" => "subnet-57498c7b"
aws_instance.dashdb_test: Creating...
  ami:                               "" => "ami-46c1b650"
  associate_public_ip_address:       "" => "<computed>"
  availability_zone:                 "" => "<computed>"
  ebs_block_device.#:                "" => "<computed>"
  ephemeral_block_device.#:          "" => "<computed>"
  instance_state:                    "" => "<computed>"
  instance_type:                     "" => "t2.micro"
  ipv6_address_count:                "" => "<computed>"
  ipv6_addresses.#:                  "" => "<computed>"
  key_name:                          "" => "brian.mckeown-aws-key"
  network_interface.#:               "" => "<computed>"
  network_interface_id:              "" => "<computed>"
  placement_group:                   "" => "<computed>"
  primary_network_interface_id:      "" => "<computed>"
  private_dns:                       "" => "<computed>"
  private_ip:                        "" => "<computed>"
  public_dns:                        "" => "<computed>"
  public_ip:                         "" => "<computed>"
  root_block_device.#:               "" => "<computed>"
  security_groups.#:                 "" => "<computed>"
  source_dest_check:                 "" => "true"
  subnet_id:                         "" => "subnet-57498c7b"
  tags.%:                            "" => "1"
  tags.Name:                         "" => "dashtst3"
  tenancy:                           "" => "<computed>"
  volume_tags.%:                     "" => "<computed>"
  vpc_security_group_ids.#:          "" => "1"
  vpc_security_group_ids.3314344846: "" => "sg-6b370215"
aws_security_group_rule.tcp_http_out: Creation complete (ID: sgrule-1579119227)
aws_efs_mount_target.dashdb_test: Still creating... (10s elapsed)
aws_instance.dashdb_test: Still creating... (10s elapsed)
aws_efs_mount_target.dashdb_test: Still creating... (20s elapsed)
aws_instance.dashdb_test: Still creating... (20s elapsed)
aws_instance.dashdb_test: Provisioning with 'remote-exec'...
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_efs_mount_target.dashdb_test: Still creating... (30s elapsed)
aws_instance.dashdb_test: Still creating... (30s elapsed)
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test: Still creating... (40s elapsed)
aws_efs_mount_target.dashdb_test: Still creating... (40s elapsed)
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_efs_mount_target.dashdb_test: Still creating... (50s elapsed)
aws_instance.dashdb_test: Still creating... (50s elapsed)
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_efs_mount_target.dashdb_test: Still creating... (1m0s elapsed)
aws_instance.dashdb_test: Still creating... (1m0s elapsed)
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test: Still creating... (1m10s elapsed)
aws_efs_mount_target.dashdb_test: Still creating... (1m10s elapsed)
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test (remote-exec): Connecting to remote host via SSH...
aws_instance.dashdb_test (remote-exec):   Host: 54.89.75.21
aws_instance.dashdb_test (remote-exec):   User: centos
aws_instance.dashdb_test (remote-exec):   Password: false
aws_instance.dashdb_test (remote-exec):   Private key: true
aws_instance.dashdb_test (remote-exec):   SSH Agent: true
aws_instance.dashdb_test: Still creating... (1m20s elapsed)
aws_efs_mount_target.dashdb_test: Still creating... (1m20s elapsed)
aws_instance.dashdb_test (remote-exec): Connected!
aws_instance.dashdb_test: Still creating... (1m30s elapsed)
aws_efs_mount_target.dashdb_test: Still creating... (1m30s elapsed)
aws_instance.dashdb_test (remote-exec): Loaded plugins: fastestmirror
aws_instance.dashdb_test: Still creating... (1m40s elapsed)
aws_efs_mount_target.dashdb_test: Still creating... (1m40s elapsed)
aws_instance.dashdb_test (remote-exec): base             | 3.6 kB     00:00
aws_instance.dashdb_test (remote-exec): extras           | 3.4 kB     00:00
aws_instance.dashdb_test (remote-exec): updates          | 3.4 kB     00:00
aws_instance.dashdb_test (remote-exec): (2/4): base/7/x 0% |    0 B   --:-- ETA
aws_instance.dashdb_test (remote-exec): (1/4): base/7/x86_ | 5.6 MB   00:00
aws_instance.dashdb_test (remote-exec): (2/4): updates/7/x | 5.6 MB   00:00
aws_instance.dashdb_test (remote-exec): (3/4): base/7/x86_ | 155 kB   00:00
aws_efs_mount_target.dashdb_test: Still creating... (1m50s elapsed)
aws_instance.dashdb_test: Still creating... (1m50s elapsed)
aws_instance.dashdb_test: Still creating... (2m0s elapsed)
aws_efs_mount_target.dashdb_test: Still creating... (2m0s elapsed)
aws_instance.dashdb_test: Still creating... (2m10s elapsed)
aws_efs_mount_target.dashdb_test: Still creating... (2m10s elapsed)
aws_instance.dashdb_test (remote-exec): extras/7/x86_64/primary_db     FAILED
aws_instance.dashdb_test (remote-exec): (4/4): extras/7 0% |    0 B   --:-- ETA
aws_instance.dashdb_test (remote-exec): http://mirror.lug.udel.edu/pub/centos/7.3.1611/extras/x86_64/repodata/65888bcf29aa87f70ed69516ffdde613b41615cf021559fe45dbf0ba77f0b52b-primary.sqlite.bz2: [Errno 12] Timeout on http://mirror.lug.udel.edu/pub/centos/7.3.1611/extras/x86_64/repodata/65888bcf29aa87f70ed69516ffdde613b41615cf021559fe45dbf0ba77f0b52b-primary.sqlite.bz2: (28, 'Connection timed out after 30001 milliseconds')
aws_instance.dashdb_test (remote-exec): Trying other mirror.
aws_instance.dashdb_test (remote-exec): (4/4): extras/7/x8 | 167 kB   00:00
aws_instance.dashdb_test (remote-exec): Determining fastest mirrors
aws_instance.dashdb_test (remote-exec):  * base: mirror.linux.duke.edu
aws_instance.dashdb_test (remote-exec):  * extras: mirror.lug.udel.edu
aws_instance.dashdb_test (remote-exec):  * updates: mirrors.lga7.us.voxel.net
aws_instance.dashdb_test (remote-exec): Resolving Dependencies
aws_instance.dashdb_test (remote-exec): --> Running transaction check
aws_instance.dashdb_test (remote-exec): ---> Package dracut.x86_64 0:033-463.el7 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package dracut.x86_64 0:033-463.el7_3.1 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package dracut-config-generic.x86_64 0:033-463.el7 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package dracut-config-generic.x86_64 0:033-463.el7_3.1 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package dracut-config-rescue.x86_64 0:033-463.el7 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package dracut-config-rescue.x86_64 0:033-463.el7_3.1 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package dracut-network.x86_64 0:033-463.el7 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package dracut-network.x86_64 0:033-463.el7_3.1 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package glibc.x86_64 0:2.17-157.el7_3.1 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package glibc.x86_64 0:2.17-157.el7_3.2 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package glibc-common.x86_64 0:2.17-157.el7_3.1 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package glibc-common.x86_64 0:2.17-157.el7_3.2 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package kernel.x86_64 0:3.10.0-514.21.1.el7 will be installed
aws_instance.dashdb_test (remote-exec): --> Processing Dependency: linux-firmware >= 20160830-49 for package: kernel-3.10.0-514.21.1.el7.x86_64
aws_instance.dashdb_test (remote-exec): ---> Package kernel-tools.x86_64 0:3.10.0-514.16.1.el7 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package kernel-tools.x86_64 0:3.10.0-514.21.1.el7 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package kernel-tools-libs.x86_64 0:3.10.0-514.16.1.el7 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package kernel-tools-libs.x86_64 0:3.10.0-514.21.1.el7 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package kpartx.x86_64 0:0.4.9-99.el7_3.1 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package kpartx.x86_64 0:0.4.9-99.el7_3.3 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package libgudev1.x86_64 0:219-30.el7_3.8 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package libgudev1.x86_64 0:219-30.el7_3.9 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package libnetfilter_conntrack.x86_64 0:1.0.4-2.el7 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package libnetfilter_conntrack.x86_64 0:1.0.6-1.el7_3 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package libtirpc.x86_64 0:0.2.4-0.8.el7 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package libtirpc.x86_64 0:0.2.4-0.8.el7_3 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package polkit.x86_64 0:0.112-11.el7_3 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package polkit.x86_64 0:0.112-12.el7_3 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package python-perf.x86_64 0:3.10.0-514.16.1.el7 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package python-perf.x86_64 0:3.10.0-514.21.1.el7 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package rdma.noarch 0:7.3_4.7_rc2-5.el7 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package rdma.noarch 0:7.3_4.7_rc2-6.el7_3 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package rpcbind.x86_64 0:0.2.0-38.el7 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package rpcbind.x86_64 0:0.2.0-38.el7_3 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package systemd.x86_64 0:219-30.el7_3.8 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package systemd.x86_64 0:219-30.el7_3.9 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package systemd-libs.x86_64 0:219-30.el7_3.8 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package systemd-libs.x86_64 0:219-30.el7_3.9 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package systemd-sysv.x86_64 0:219-30.el7_3.8 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package systemd-sysv.x86_64 0:219-30.el7_3.9 will be an update
aws_instance.dashdb_test (remote-exec): ---> Package tuned.noarch 0:2.7.1-3.el7_3.1 will be updated
aws_instance.dashdb_test (remote-exec): ---> Package tuned.noarch 0:2.7.1-3.el7_3.2 will be an update
aws_instance.dashdb_test (remote-exec): --> Running transaction check
aws_instance.dashdb_test (remote-exec): ---> Package linux-firmware.noarch 0:20160830-49.git7534e19.el7 will be installed
aws_instance.dashdb_test (remote-exec): --> Finished Dependency Resolution

aws_instance.dashdb_test (remote-exec): Dependencies Resolved

aws_instance.dashdb_test (remote-exec): ========================================
aws_instance.dashdb_test (remote-exec):  Package        Arch   Version
aws_instance.dashdb_test (remote-exec):                           Repository
aws_instance.dashdb_test (remote-exec):                                    Size
aws_instance.dashdb_test (remote-exec): ========================================
aws_instance.dashdb_test (remote-exec): Installing:
aws_instance.dashdb_test (remote-exec):  kernel         x86_64 3.10.0-514.21.1.el7
aws_instance.dashdb_test (remote-exec):                           updates  37 M
aws_instance.dashdb_test (remote-exec): Updating:
aws_instance.dashdb_test (remote-exec):  dracut         x86_64 033-463.el7_3.1
aws_instance.dashdb_test (remote-exec):                           updates 317 k
aws_instance.dashdb_test (remote-exec):  dracut-config-generic
aws_instance.dashdb_test (remote-exec):                 x86_64 033-463.el7_3.1
aws_instance.dashdb_test (remote-exec):                           updates  52 k
aws_instance.dashdb_test (remote-exec):  dracut-config-rescue
aws_instance.dashdb_test (remote-exec):                 x86_64 033-463.el7_3.1
aws_instance.dashdb_test (remote-exec):                           updates  54 k
aws_instance.dashdb_test (remote-exec):  dracut-network x86_64 033-463.el7_3.1
aws_instance.dashdb_test (remote-exec):                           updates  96 k
aws_instance.dashdb_test (remote-exec):  glibc          x86_64 2.17-157.el7_3.2
aws_instance.dashdb_test (remote-exec):                           updates 3.6 M
aws_instance.dashdb_test (remote-exec):  glibc-common   x86_64 2.17-157.el7_3.2
aws_instance.dashdb_test (remote-exec):                           updates  11 M
aws_instance.dashdb_test (remote-exec):  kernel-tools   x86_64 3.10.0-514.21.1.el7
aws_instance.dashdb_test (remote-exec):                           updates 4.0 M
aws_instance.dashdb_test (remote-exec):  kernel-tools-libs
aws_instance.dashdb_test (remote-exec):                 x86_64 3.10.0-514.21.1.el7
aws_instance.dashdb_test (remote-exec):                           updates 3.9 M
aws_instance.dashdb_test (remote-exec):  kpartx         x86_64 0.4.9-99.el7_3.3
aws_instance.dashdb_test (remote-exec):                           updates  68 k
aws_instance.dashdb_test (remote-exec):  libgudev1      x86_64 219-30.el7_3.9
aws_instance.dashdb_test (remote-exec):                           updates  77 k
aws_instance.dashdb_test (remote-exec):  libnetfilter_conntrack
aws_instance.dashdb_test (remote-exec):                 x86_64 1.0.6-1.el7_3
aws_instance.dashdb_test (remote-exec):                           updates  55 k
aws_instance.dashdb_test (remote-exec):  libtirpc       x86_64 0.2.4-0.8.el7_3
aws_instance.dashdb_test (remote-exec):                           updates  88 k
aws_instance.dashdb_test (remote-exec):  polkit         x86_64 0.112-12.el7_3
aws_instance.dashdb_test (remote-exec):                           updates 167 k
aws_instance.dashdb_test (remote-exec):  python-perf    x86_64 3.10.0-514.21.1.el7
aws_instance.dashdb_test (remote-exec):                           updates 4.0 M
aws_instance.dashdb_test (remote-exec):  rdma           noarch 7.3_4.7_rc2-6.el7_3
aws_instance.dashdb_test (remote-exec):                           updates  30 k
aws_instance.dashdb_test (remote-exec):  rpcbind        x86_64 0.2.0-38.el7_3
aws_instance.dashdb_test (remote-exec):                           updates  59 k
aws_instance.dashdb_test (remote-exec):  systemd        x86_64 219-30.el7_3.9
aws_instance.dashdb_test (remote-exec):                           updates 5.2 M
aws_instance.dashdb_test (remote-exec):  systemd-libs   x86_64 219-30.el7_3.9
aws_instance.dashdb_test (remote-exec):                           updates 369 k
aws_instance.dashdb_test (remote-exec):  systemd-sysv   x86_64 219-30.el7_3.9
aws_instance.dashdb_test (remote-exec):                           updates  64 k
aws_instance.dashdb_test (remote-exec):  tuned          noarch 2.7.1-3.el7_3.2
aws_instance.dashdb_test (remote-exec):                           updates 210 k
aws_instance.dashdb_test (remote-exec): Installing for dependencies:
aws_instance.dashdb_test (remote-exec):  linux-firmware noarch 20160830-49.git7534e19.el7
aws_instance.dashdb_test (remote-exec):                           base     31 M

aws_instance.dashdb_test (remote-exec): Transaction Summary
aws_instance.dashdb_test (remote-exec): ========================================
aws_instance.dashdb_test (remote-exec): Install   1 Package  (+1 Dependent package)
aws_instance.dashdb_test (remote-exec): Upgrade  20 Packages

aws_instance.dashdb_test (remote-exec): Total download size: 103 M
aws_instance.dashdb_test (remote-exec): Downloading packages:
aws_instance.dashdb_test (remote-exec): Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
aws_instance.dashdb_test (remote-exec): warning: /var/cache/yum/x86_64/7/updates/packages/dracut-config-generic-033-463.el7_3.1.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID f4a80eb5: NOKEY
aws_instance.dashdb_test (remote-exec): Public key for dracut-config-generic-033-463.el7_3.1.x86_64.rpm is not installed
aws_instance.dashdb_test (remote-exec): (1/22): dracut-con |  52 kB   00:00
aws_instance.dashdb_test (remote-exec): (2/22): dracut-con |  54 kB   00:00
aws_instance.dashdb_test (remote-exec): (3/22): dracut-033 | 317 kB   00:00
aws_instance.dashdb_test (remote-exec): (4/22): dracut-net |  96 kB   00:00
aws_instance.dashdb_test (remote-exec): (5/22): glibc-2.17 | 3.6 MB   00:00
aws_instance.dashdb_test (remote-exec): (7/22): kernel- 7% | 8.2 MB   --:-- ETA
aws_instance.dashdb_test (remote-exec): (6/22): glibc-comm |  11 MB   00:00
aws_instance.dashdb_test (remote-exec): (8/22): kernel 39% |  41 MB   00:02 ETA
aws_instance.dashdb_test (remote-exec): (7/22): kernel-too | 4.0 MB   00:00
aws_instance.dashdb_test (remote-exec): (8/22): kernel-3.1 |  37 MB   00:01
aws_instance.dashdb_test (remote-exec): (9/22): kernel-too | 3.9 MB   00:00
aws_instance.dashdb_test (remote-exec): (10/22): kpartx-0. |  68 kB   00:00
aws_instance.dashdb_test (remote-exec): (11/22): libgudev1 |  77 kB   00:00
aws_instance.dashdb_test (remote-exec): (12/22): libnetfil |  55 kB   00:00
aws_instance.dashdb_test (remote-exec): (13/22): libtirpc- |  88 kB   00:00
aws_instance.dashdb_test (remote-exec): (14/22): polkit-0. | 167 kB   00:00
aws_instance.dashdb_test (remote-exec): (15/22): rdma-7.3_ |  30 kB   00:00
aws_instance.dashdb_test (remote-exec): (16/22): rpcbind-0 |  59 kB   00:00
aws_instance.dashdb_test (remote-exec): (17/22): systemd-2 | 5.2 MB   00:00
aws_instance.dashdb_test (remote-exec): (20/22): syste 67% |  69 MB   00:01 ETA
aws_instance.dashdb_test (remote-exec): (18/22): python-pe | 4.0 MB   00:00
aws_instance.dashdb_test (remote-exec): (19/22): systemd-s |  64 kB   00:00
aws_instance.dashdb_test (remote-exec): (20/22): tuned-2.7 | 210 kB   00:00
aws_instance.dashdb_test (remote-exec): (21/22): systemd-l | 369 kB   00:00
aws_instance.dashdb_test (remote-exec): (22/22): linux 99% | 102 MB   00:00 ETA
aws_instance.dashdb_test (remote-exec): Public key for linux-firmware-20160830-49.git7534e19.el7.noarch.rpm is not installed
aws_instance.dashdb_test (remote-exec): (22/22): linux-fir |  31 MB   00:00
aws_instance.dashdb_test (remote-exec): ----------------------------------------
aws_instance.dashdb_test (remote-exec): Total       40 MB/s | 103 MB  00:02
aws_instance.dashdb_test (remote-exec): Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
aws_instance.dashdb_test (remote-exec): Importing GPG key 0xF4A80EB5:
aws_instance.dashdb_test (remote-exec):  Userid     : "CentOS-7 Key (CentOS 7 Official Signing Key) <security@centos.org>"
aws_instance.dashdb_test (remote-exec):  Fingerprint: 6341 ab27 53d7 8a78 a7c2 7bb1 24c6 a8a7 f4a8 0eb5
aws_instance.dashdb_test (remote-exec):  Package    : centos-release-7-3.1611.el7.centos.x86_64 (installed)
aws_instance.dashdb_test (remote-exec):  From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
aws_efs_mount_target.dashdb_test: Still creating... (2m20s elapsed)
aws_instance.dashdb_test: Still creating... (2m20s elapsed)
aws_efs_mount_target.dashdb_test: Still creating... (2m30s elapsed)
aws_instance.dashdb_test: Still creating... (2m30s elapsed)
aws_instance.dashdb_test: Still creating... (2m40s elapsed)
aws_efs_mount_target.dashdb_test: Still creating... (2m40s elapsed)
aws_efs_mount_target.dashdb_test: Creation complete (ID: fsmt-f33ab4ba)
aws_instance.dashdb_test (remote-exec): Running transaction check
aws_instance.dashdb_test (remote-exec): Running transaction test
aws_instance.dashdb_test: Still creating... (2m50s elapsed)
aws_instance.dashdb_test (remote-exec): Transaction test succeeded
aws_instance.dashdb_test (remote-exec): Running transaction
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-c [        ]  1/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-c [#       ]  1/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-c [##      ]  1/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-c [###     ]  1/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-c [####    ]  1/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-c [#####   ]  1/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-c [######  ]  1/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-c [####### ]  1/42
aws_instance.dashdb_test: Still creating... (3m0s elapsed)
aws_instance.dashdb_test: Still creating... (3m10s elapsed)
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-common-2.1    1/42
aws_instance.dashdb_test: Still creating... (3m20s elapsed)
aws_instance.dashdb_test: Still creating... (3m30s elapsed)
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-2 [        ]  2/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-2 [#       ]  2/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-2 [##      ]  2/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-2 [###     ]  2/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-2 [####    ]  2/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-2 [#####   ]  2/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-2 [######  ]  2/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-2 [####### ]  2/42
aws_instance.dashdb_test (remote-exec):   Updating   : glibc-2.17-157.e    2/42
aws_instance.dashdb_test: Still creating... (3m40s elapsed)
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [        ]  3/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [#       ]  3/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [##      ]  3/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [###     ]  3/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [####    ]  3/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [#####   ]  3/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [######  ]  3/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [####### ]  3/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd-libs-219    3/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [        ]  4/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [#       ]  4/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [##      ]  4/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [###     ]  4/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [####    ]  4/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [#####   ]  4/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [######  ]  4/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [####### ]  4/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd-219-30.e    4/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [        ]  5/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd [####### ]  5/42
aws_instance.dashdb_test (remote-exec):   Updating   : systemd-sysv-219    5/42
aws_instance.dashdb_test (remote-exec):   Updating   : polkit- [        ]  6/42
aws_instance.dashdb_test (remote-exec):   Updating   : polkit- [#       ]  6/42
aws_instance.dashdb_test (remote-exec):   Updating   : polkit- [##      ]  6/42
aws_instance.dashdb_test (remote-exec):   Updating   : polkit- [###     ]  6/42
aws_instance.dashdb_test (remote-exec):   Updating   : polkit- [####    ]  6/42
aws_instance.dashdb_test (remote-exec):   Updating   : polkit- [#####   ]  6/42
aws_instance.dashdb_test (remote-exec):   Updating   : polkit- [######  ]  6/42
aws_instance.dashdb_test (remote-exec):   Updating   : polkit- [####### ]  6/42
aws_instance.dashdb_test (remote-exec):   Updating   : polkit-0.112-12.    6/42
aws_instance.dashdb_test (remote-exec):   Updating   : kpartx- [        ]  7/42
aws_instance.dashdb_test (remote-exec):   Updating   : kpartx- [####### ]  7/42
aws_instance.dashdb_test (remote-exec):   Updating   : kpartx-0.4.9-99.    7/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [        ]  8/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [#       ]  8/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [##      ]  8/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [###     ]  8/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [####    ]  8/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [#####   ]  8/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [######  ]  8/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [####### ]  8/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut-033-463.e    8/42
aws_instance.dashdb_test (remote-exec):   Updating   : python- [        ]  9/42
aws_instance.dashdb_test (remote-exec):   Updating   : python- [#       ]  9/42
aws_instance.dashdb_test (remote-exec):   Updating   : python- [###     ]  9/42
aws_instance.dashdb_test (remote-exec):   Updating   : python- [#####   ]  9/42
aws_instance.dashdb_test (remote-exec):   Updating   : python- [######  ]  9/42
aws_instance.dashdb_test (remote-exec):   Updating   : python- [####### ]  9/42
aws_instance.dashdb_test (remote-exec):   Updating   : python-perf-3.10    9/42
aws_instance.dashdb_test (remote-exec):   Updating   : kernel- [        ] 10/42
aws_instance.dashdb_test (remote-exec):   Updating   : kernel- [####### ] 10/42
aws_instance.dashdb_test (remote-exec):   Updating   : kernel-tools-lib   10/42
aws_instance.dashdb_test (remote-exec):   Updating   : libtirp [        ] 11/42
aws_instance.dashdb_test (remote-exec):   Updating   : libtirp [##      ] 11/42
aws_instance.dashdb_test (remote-exec):   Updating   : libtirp [#####   ] 11/42
aws_instance.dashdb_test (remote-exec):   Updating   : libtirp [####### ] 11/42
aws_instance.dashdb_test (remote-exec):   Updating   : libtirpc-0.2.4-0   11/42
aws_instance.dashdb_test (remote-exec):   Installing : linux-f [        ] 12/42
aws_instance.dashdb_test (remote-exec):   Installing : linux-f [#       ] 12/42
aws_instance.dashdb_test: Still creating... (3m50s elapsed)
aws_instance.dashdb_test (remote-exec):   Installing : linux-f [##      ] 12/42
aws_instance.dashdb_test (remote-exec):   Installing : linux-f [###     ] 12/42
aws_instance.dashdb_test (remote-exec):   Installing : linux-f [####    ] 12/42
aws_instance.dashdb_test (remote-exec):   Installing : linux-f [#####   ] 12/42
aws_instance.dashdb_test (remote-exec):   Installing : linux-f [######  ] 12/42
aws_instance.dashdb_test: Still creating... (4m0s elapsed)
aws_instance.dashdb_test (remote-exec):   Installing : linux-f [####### ] 12/42
aws_instance.dashdb_test (remote-exec):   Installing : linux-firmware-2   12/42
aws_instance.dashdb_test (remote-exec):   Installing : kernel- [        ] 13/42
aws_instance.dashdb_test: Still creating... (4m10s elapsed)
aws_instance.dashdb_test (remote-exec):   Installing : kernel- [#       ] 13/42
aws_instance.dashdb_test (remote-exec):   Installing : kernel- [##      ] 13/42
aws_instance.dashdb_test (remote-exec):   Installing : kernel- [###     ] 13/42
aws_instance.dashdb_test (remote-exec):   Installing : kernel- [####    ] 13/42
aws_instance.dashdb_test: Still creating... (4m20s elapsed)
aws_instance.dashdb_test (remote-exec):   Installing : kernel- [#####   ] 13/42
aws_instance.dashdb_test (remote-exec):   Installing : kernel- [######  ] 13/42
aws_instance.dashdb_test: Still creating... (4m30s elapsed)
aws_instance.dashdb_test (remote-exec):   Installing : kernel- [####### ] 13/42
aws_instance.dashdb_test (remote-exec):   Installing : kernel-3.10.0-51   13/42
aws_instance.dashdb_test: Still creating... (4m40s elapsed)
aws_instance.dashdb_test (remote-exec):   Updating   : rpcbind [        ] 14/42
aws_instance.dashdb_test (remote-exec):   Updating   : rpcbind [####    ] 14/42
aws_instance.dashdb_test (remote-exec):   Updating   : rpcbind [######  ] 14/42
aws_instance.dashdb_test (remote-exec):   Updating   : rpcbind [####### ] 14/42
aws_instance.dashdb_test (remote-exec):   Updating   : rpcbind-0.2.0-38   14/42
aws_instance.dashdb_test (remote-exec):   Updating   : kernel- [        ] 15/42
aws_instance.dashdb_test (remote-exec):   Updating   : kernel- [##      ] 15/42
aws_instance.dashdb_test (remote-exec):   Updating   : kernel- [###     ] 15/42
aws_instance.dashdb_test (remote-exec):   Updating   : kernel- [#####   ] 15/42
aws_instance.dashdb_test (remote-exec):   Updating   : kernel- [######  ] 15/42
aws_instance.dashdb_test (remote-exec):   Updating   : kernel- [####### ] 15/42
aws_instance.dashdb_test (remote-exec):   Updating   : kernel-tools-3.1   15/42
aws_instance.dashdb_test (remote-exec):   Updating   : tuned-2 [        ] 16/42
aws_instance.dashdb_test (remote-exec):   Updating   : tuned-2 [#       ] 16/42
aws_instance.dashdb_test (remote-exec):   Updating   : tuned-2 [##      ] 16/42
aws_instance.dashdb_test (remote-exec):   Updating   : tuned-2 [###     ] 16/42
aws_instance.dashdb_test (remote-exec):   Updating   : tuned-2 [####    ] 16/42
aws_instance.dashdb_test (remote-exec):   Updating   : tuned-2 [#####   ] 16/42
aws_instance.dashdb_test (remote-exec):   Updating   : tuned-2 [######  ] 16/42
aws_instance.dashdb_test (remote-exec):   Updating   : tuned-2 [####### ] 16/42
aws_instance.dashdb_test (remote-exec):   Updating   : tuned-2.7.1-3.el   16/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [        ] 17/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [###     ] 17/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [####### ] 17/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut-config-re   17/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [        ] 18/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [####    ] 18/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut-config-ge   18/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [        ] 19/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [#       ] 19/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [##      ] 19/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [###     ] 19/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [####    ] 19/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [#####   ] 19/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [######  ] 19/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut- [####### ] 19/42
aws_instance.dashdb_test (remote-exec):   Updating   : dracut-network-0   19/42
aws_instance.dashdb_test (remote-exec):   Updating   : rdma-7. [        ] 20/42
aws_instance.dashdb_test (remote-exec):   Updating   : rdma-7. [##      ] 20/42
aws_instance.dashdb_test (remote-exec):   Updating   : rdma-7. [###     ] 20/42
aws_instance.dashdb_test (remote-exec):   Updating   : rdma-7. [####    ] 20/42
aws_instance.dashdb_test (remote-exec):   Updating   : rdma-7. [#####   ] 20/42
aws_instance.dashdb_test (remote-exec):   Updating   : rdma-7. [######  ] 20/42
aws_instance.dashdb_test (remote-exec):   Updating   : rdma-7. [####### ] 20/42
aws_instance.dashdb_test (remote-exec):   Updating   : rdma-7.3_4.7_rc2   20/42
aws_instance.dashdb_test (remote-exec):   Updating   : libgude [        ] 21/42
aws_instance.dashdb_test (remote-exec):   Updating   : libgude [#       ] 21/42
aws_instance.dashdb_test (remote-exec):   Updating   : libgude [####### ] 21/42
aws_instance.dashdb_test (remote-exec):   Updating   : libgudev1-219-30   21/42
aws_instance.dashdb_test (remote-exec):   Updating   : libnetf [        ] 22/42
aws_instance.dashdb_test (remote-exec):   Updating   : libnetf [###     ] 22/42
aws_instance.dashdb_test (remote-exec):   Updating   : libnetf [######  ] 22/42
aws_instance.dashdb_test (remote-exec):   Updating   : libnetf [####### ] 22/42
aws_instance.dashdb_test (remote-exec):   Updating   : libnetfilter_con   22/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : tuned-2.7.1-3.el   23/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : rpcbind-0.2.0-38   24/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : rdma-7.3_4.7_rc2   25/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : systemd-sysv-219   26/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : dracut-network-0   27/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : dracut-config-ge   28/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : dracut-config-re   29/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : polkit-0.112-11.   30/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : libgudev1-219-30   31/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : kernel-tools-3.1   32/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : dracut-033-463.e   33/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : systemd-219-30.e   34/42
aws_instance.dashdb_test: Still creating... (4m50s elapsed)
aws_instance.dashdb_test (remote-exec):   Cleanup    : systemd-libs-219   35/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : kpartx-0.4.9-99.   36/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : kernel-tools-lib   37/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : libtirpc-0.2.4-0   38/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : python-perf-3.10   39/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : libnetfilter_con   40/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : glibc-common-2.1   41/42
aws_instance.dashdb_test (remote-exec):   Cleanup    : glibc-2.17-157.e   42/42
aws_instance.dashdb_test: Still creating... (5m0s elapsed)
aws_instance.dashdb_test: Still creating... (5m10s elapsed)
aws_instance.dashdb_test: Still creating... (5m20s elapsed)
aws_instance.dashdb_test: Still creating... (5m30s elapsed)
aws_instance.dashdb_test: Still creating... (5m40s elapsed)
aws_instance.dashdb_test: Still creating... (5m50s elapsed)
aws_instance.dashdb_test (remote-exec):   Verifying  : tuned-2.7.1-3.el    1/42
aws_instance.dashdb_test (remote-exec):   Verifying  : rpcbind-0.2.0-38    2/42
aws_instance.dashdb_test (remote-exec):   Verifying  : dracut-config-re    3/42
aws_instance.dashdb_test (remote-exec):   Verifying  : kernel-tools-3.1    4/42
aws_instance.dashdb_test (remote-exec):   Verifying  : libnetfilter_con    5/42
aws_instance.dashdb_test (remote-exec):   Verifying  : dracut-config-ge    6/42
aws_instance.dashdb_test (remote-exec):   Verifying  : glibc-2.17-157.e    7/42
aws_instance.dashdb_test (remote-exec):   Verifying  : kernel-3.10.0-51    8/42
aws_instance.dashdb_test (remote-exec):   Verifying  : kpartx-0.4.9-99.    9/42
aws_instance.dashdb_test (remote-exec):   Verifying  : dracut-network-0   10/42
aws_instance.dashdb_test (remote-exec):   Verifying  : dracut-033-463.e   11/42
aws_instance.dashdb_test (remote-exec):   Verifying  : rdma-7.3_4.7_rc2   12/42
aws_instance.dashdb_test (remote-exec):   Verifying  : systemd-sysv-219   13/42
aws_instance.dashdb_test (remote-exec):   Verifying  : python-perf-3.10   14/42
aws_instance.dashdb_test (remote-exec):   Verifying  : systemd-libs-219   15/42
aws_instance.dashdb_test (remote-exec):   Verifying  : libgudev1-219-30   16/42
aws_instance.dashdb_test (remote-exec):   Verifying  : kernel-tools-lib   17/42
aws_instance.dashdb_test (remote-exec):   Verifying  : glibc-common-2.1   18/42
aws_instance.dashdb_test (remote-exec):   Verifying  : libtirpc-0.2.4-0   19/42
aws_instance.dashdb_test (remote-exec):   Verifying  : polkit-0.112-12.   20/42
aws_instance.dashdb_test (remote-exec):   Verifying  : linux-firmware-2   21/42
aws_instance.dashdb_test (remote-exec):   Verifying  : systemd-219-30.e   22/42
aws_instance.dashdb_test (remote-exec):   Verifying  : kernel-tools-lib   23/42
aws_instance.dashdb_test (remote-exec):   Verifying  : systemd-sysv-219   24/42
aws_instance.dashdb_test (remote-exec):   Verifying  : python-perf-3.10   25/42
aws_instance.dashdb_test (remote-exec):   Verifying  : glibc-common-2.1   26/42
aws_instance.dashdb_test (remote-exec):   Verifying  : dracut-033-463.e   27/42
aws_instance.dashdb_test (remote-exec):   Verifying  : dracut-network-0   28/42
aws_instance.dashdb_test (remote-exec):   Verifying  : libnetfilter_con   29/42
aws_instance.dashdb_test (remote-exec):   Verifying  : systemd-libs-219   30/42
aws_instance.dashdb_test (remote-exec):   Verifying  : systemd-219-30.e   31/42
aws_instance.dashdb_test (remote-exec):   Verifying  : glibc-2.17-157.e   32/42
aws_instance.dashdb_test (remote-exec):   Verifying  : tuned-2.7.1-3.el   33/42
aws_instance.dashdb_test (remote-exec):   Verifying  : dracut-config-re   34/42
aws_instance.dashdb_test (remote-exec):   Verifying  : kernel-tools-3.1   35/42
aws_instance.dashdb_test (remote-exec):   Verifying  : libgudev1-219-30   36/42
aws_instance.dashdb_test (remote-exec):   Verifying  : kpartx-0.4.9-99.   37/42
aws_instance.dashdb_test (remote-exec):   Verifying  : polkit-0.112-11.   38/42
aws_instance.dashdb_test (remote-exec):   Verifying  : rdma-7.3_4.7_rc2   39/42
aws_instance.dashdb_test (remote-exec):   Verifying  : rpcbind-0.2.0-38   40/42
aws_instance.dashdb_test (remote-exec):   Verifying  : dracut-config-ge   41/42
aws_instance.dashdb_test (remote-exec):   Verifying  : libtirpc-0.2.4-0   42/42

aws_instance.dashdb_test (remote-exec): Installed:
aws_instance.dashdb_test (remote-exec):   kernel.x86_64 0:3.10.0-514.21.1.el7

aws_instance.dashdb_test (remote-exec): Dependency Installed:
aws_instance.dashdb_test (remote-exec):   linux-firmware.noarch 0:20160830-49.git7534e19.el7

aws_instance.dashdb_test (remote-exec): Updated:
aws_instance.dashdb_test (remote-exec):   dracut.x86_64 0:033-463.el7_3.1
aws_instance.dashdb_test (remote-exec):   dracut-config-generic.x86_64 0:033-463.el7_3.1
aws_instance.dashdb_test (remote-exec):   dracut-config-rescue.x86_64 0:033-463.el7_3.1
aws_instance.dashdb_test (remote-exec):   dracut-network.x86_64 0:033-463.el7_3.1
aws_instance.dashdb_test (remote-exec):   glibc.x86_64 0:2.17-157.el7_3.2
aws_instance.dashdb_test (remote-exec):   glibc-common.x86_64 0:2.17-157.el7_3.2
aws_instance.dashdb_test (remote-exec):   kernel-tools.x86_64 0:3.10.0-514.21.1.el7
aws_instance.dashdb_test (remote-exec):   kernel-tools-libs.x86_64 0:3.10.0-514.21.1.el7
aws_instance.dashdb_test (remote-exec):   kpartx.x86_64 0:0.4.9-99.el7_3.3
aws_instance.dashdb_test (remote-exec):   libgudev1.x86_64 0:219-30.el7_3.9
aws_instance.dashdb_test (remote-exec):   libnetfilter_conntrack.x86_64 0:1.0.6-1.el7_3
aws_instance.dashdb_test (remote-exec):   libtirpc.x86_64 0:0.2.4-0.8.el7_3
aws_instance.dashdb_test (remote-exec):   polkit.x86_64 0:0.112-12.el7_3
aws_instance.dashdb_test (remote-exec):   python-perf.x86_64 0:3.10.0-514.21.1.el7
aws_instance.dashdb_test (remote-exec):   rdma.noarch 0:7.3_4.7_rc2-6.el7_3
aws_instance.dashdb_test (remote-exec):   rpcbind.x86_64 0:0.2.0-38.el7_3
aws_instance.dashdb_test (remote-exec):   systemd.x86_64 0:219-30.el7_3.9
aws_instance.dashdb_test (remote-exec):   systemd-libs.x86_64 0:219-30.el7_3.9
aws_instance.dashdb_test (remote-exec):   systemd-sysv.x86_64 0:219-30.el7_3.9
aws_instance.dashdb_test (remote-exec):   tuned.noarch 0:2.7.1-3.el7_3.2

aws_instance.dashdb_test (remote-exec): Complete!
aws_instance.dashdb_test: Creation complete (ID: i-0dc2c7bc4fd26c39d)

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: 
brians-mbp:terra1 bmdu1569$ 


Login to the EC2 instance. Can see EFS has been mounted:


brians-mbp:.ssh bmdu1569$ ssh -i "brian.mckeown-aws-key.pem" centos@ec2-54-89-75-21.compute-1.amazonaws.com
Last login: Mon May 29 16:53:24 2017 from gbibp9ph1--blueice4n1.emea.ibm.com
[centos@ip-10-0-0-54 ~]$ df -T
Filesystem                                Type            1K-blocks    Used        Available Use% Mounted on
/dev/xvda1                                xfs               8377344 1443344          6934000  18% /
devtmpfs                                  devtmpfs           487880       0           487880   0% /dev
tmpfs                                     tmpfs              507488       0           507488   0% /dev/shm
tmpfs                                     tmpfs              507488   12928           494560   3% /run
tmpfs                                     tmpfs              507488       0           507488   0% /sys/fs/cgroup
fs-99e561d0.efs.us-east-1.amazonaws.com:/ nfs4     9007199254740992       0 9007199254740992   0% /mnt/efs
tmpfs                                     tmpfs              101500       0           101500   0% /run/user/1000

