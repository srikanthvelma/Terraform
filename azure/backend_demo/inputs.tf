variable "resource_group_name" {
  type    = string
  default = "vnetrg"
}
variable "location" {
  type    = string
  default = "East US"
}
variable "virtual_network_name" {
  type    = string
  default = "vnet1"
}
variable "address_space" {
  type    = list(string)
  default = ["192.168.0.0/16"]
}
variable "subnets" {
  type    = list(string)
  default = ["subnet1"]
}
