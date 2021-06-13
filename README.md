# Terraform Provisioning VPC with 2 Subnet and Auto Scaling Group


# Preparing AWS IAM Credential


Get Access key ID,Secret access key for accessing AWS 

![](https://s2.im.ge/2021/06/13/QD5cJ.png)

Download .csv file and store on your safe storage.


# Prerequisites

- Install terraform
  
- Install awscli and setup awscli with run ```aws configure``` 

```
├── terraform-vpc-asg
    ├── modules
    │   ├── vpc
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   └── asg
    │       ├── main.tf
    │       └── variables.tf
    ├── variables.tf
    ├── provider.tf
    ├── outputs.tf
    └── main.tf
```

# Preparing variables
- You can change value of profile on ```provider.tf``` file to your profile aws.
```
provider "aws" {
  region  = "${var.region}"
  /* change to your profile, run aws configure list*/
  profile = "default" 
}
```

- You can change default value on ```variables.tf``` file. Like this following :
```
variable "region" {
  description = "Region Singapore"
  /* change to your default Region */
  default = "ap-southeast-1"
}

variable "environment" {
  description = "The Deployment environment"
  /* change to your environment name */
  default = "development"
}

//Networking
variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
  /* change to your CIDR vpc */
  default = "10.69.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list
  description = "The CIDR block for the public subnet"
  /* change to your public subnet of vpc */
  default = ["10.69.69.0/24"]
}

variable "private_subnets_cidr" {
  type        = list
  description = "The CIDR block for the private subnet"
  /* change to your private subnet of vpc */
  default = ["10.69.169.0/24"]
}

variable "key_name" {
  type = string
  description = "key_name ssh"
  /* change to your private key name on AWS */
  default = "gusty" 
}

variable "image_id" {
  type = string
  description = "image id ami your have"
  /* change to ami you want or you have */
  default =  "ami-0c795d545315cbfb0"
}

variable "instance_type" {
  description = "instance type for ec2"
  /* change to instance type you want */
  default = "t2.medium"
  
}

```
or

you can add ```terraform.tfvars``` file for change the default value of variable. Like following this :
```
region      = "<<AWS region>>"
environment = "<<your setup environment name>>"
vpc_cidr             = "<<VPC CIDR example 10.69.0.0/16>"
public_subnets_cidr  = ["10.69.69.0/24"] //List of Public subnet cidr range
private_subnets_cidr = ["10.69.169.0/24"] //List of private subnet cidr range
key_name = "<<Private Key for SSH Access>>"
image_id = "<<your image id / ami >>"
instance_type = "<< your instance type want>>"
```

# For running terraform

Initialize terraform :
```
terraform init
```
Plan and check your initialize with this command :
```
terraform plan
```
Run this command for applying your provisioning :
```
terraform apply
```
