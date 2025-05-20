variable "ec2_instance_type" {
    default = "t2.micro"
    type = string
}

variable "ec2_root_storage_size" {
  default = 15
  type = number
}

variable "ec2_ami_id" {
  default = "ami-04f167a56786e4b09"
  type = string
}