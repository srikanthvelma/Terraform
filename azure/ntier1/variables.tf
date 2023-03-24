variable "resource_group_name" {
  type    = string
  default = "ntierrg"

}

variable "location" {
  type        = string
  default     = "East US"
  description = "resource group location"

}

variable "address_space" {
  type        = list(string)
  default     = ["192.168.0.0/16"]
  description = "vnet address"

}
variable "vnet_name" {
  type        = string
  default     = "ntiervnet"
  description = "vnet name"

}
variable "subnet_names" {
  type        = list(string)
  default     = ["app1", "app2", "db1", "db2"]
  description = "subnet names"

}
variable "address_prefix" {
  type        = list(string)
  default     = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  description = "subnet addresses"

}