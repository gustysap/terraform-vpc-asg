variable "region" {
  description = "Region Singapore"
  default = "ap-southeast-1"
}

variable "environment" {
  description = "The Deployment environment"
  default = "development"
}

//Networking
variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
  default = "10.69.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list
  description = "The CIDR block for the public subnet"
  default = ["10.69.69.0/24"]
}

variable "private_subnets_cidr" {
  type        = list
  description = "The CIDR block for the private subnet"
  default = ["10.69.169.0/24"]
}

variable "key_name" {
  type = string
  description = "key_name ssh"
  default = "gusty"
}

variable "image_id" {
  type = string
  description = "image id ami your have"
  default =  "ami-0c795d545315cbfb0"
}

variable "instance_type" {
  description = "instance type for ec2"
  default = "t2.medium"
  
}
