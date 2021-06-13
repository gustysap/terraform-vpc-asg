variable "vpc_id" {
  description = "vpc_id"
}
 
variable "environment" {
  description = "The Deployment environment"
} 
 
variable "image_id" {
  type = string
  default =  "ami-0c795d545315cbfb0"
}
 
variable "instance_type" {
  default = "t2.medium"
}

variable "private_subnets_id" {
  type = set(string)
  description = "private subnet id"
}

variable "security_groups_ids" {
  description = "security group from module vpc"
}

variable "key_name" {
  description = "your key name ssh"
}
