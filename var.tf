variable "vpcname" {
  default = "EarthVPC_TF"
}

##VPC Network defined
variable "block0" {
  default = "10.0.0.0/20"
}

#Subnet 1 defined
variable "block1" {
  default = "10.0.1.0/24"
}

#Subnet 2 defined
variable "block2" {
  default = "10.0.2.0/24"
}

#RouteTable path defined
variable "block3" {
  default = "0.0.0.0/0"
}