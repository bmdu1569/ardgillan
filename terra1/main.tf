provider "aws" {
  region = "us-east-1"
  #shared_credentials_file = "/Users/bmdu1569/.aws/credentials"
  access_key = "ASIAJYFYAHIV7BBZTK4Q"
  secret_key = "i4EmSqCqvuUm3KVMIlx4+ApzZ/3EuAetNsavpCBJ"
  token = "FQoDYXdzEBMaDD4RejSptUVHdhr89CLeAqXOJD/+C5iXAYYLeiA9x0IGoAnmwXZGN43SzINXYkvqUFKod0Omf+s34hJDvmc0o/AeM2pEt7mirf751bOls0KaNzofuFf5CKudaUrejwiknz24tvwNIP4EC6aSboUSdXiKbPdw/8t6P1ZPZp2Q+yth4XY01wJSUpVPngwLcuWDQEdm10NJ0luI7x6SYnRzdptYbGXpoVK/mwu9YKEVCfb0S4y6e4xdksas80k5XBVurrcAsu5Qp3L94SqCqhR4snFPytholv2sx7VZ4ebKohvNU3Ad4hXPlo82GcbOaqPTn/wTHujQl2Dbx0NlJF0pl2iRL8jJiNlCookg5moPvkUmXUfZNd4VtkxX6FJkz5pmFxrAclgBEDOw2U507c+FQLDKr2b8ogq9InpDPfBxh4lMj4iwiVkh9KWmBYbsMXeE02OrCxjLIKdqF6dYei2BtyX/TRBk4DX9UT5qtCdnKKaK68gF"
}

resource "aws_instance" "dashDB_local" {
ami = "ami-0932686c"
instance_type = "t2.micro"
}
