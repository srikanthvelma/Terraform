variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region to create resources"
}

variable "ntier_vpc_info" {
  type = object({
    vpc_cidr       = string,
    subnet_azs     = list(string),
    subnet_names   = list(string),
    public_subnets = list(string)
  })
  default = {
    subnet_names   = ["web1"]
    vpc_cidr       = "192.168.0.0/16"
    public_subnets = ["web1"]
    subnet_azs     = ["a", "b"]
  }
}