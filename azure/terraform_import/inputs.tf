variable "subnet_info" {
    type = object({
        name = list(string)
        address_prefixes =list(string)
    })
    default = {
      address_prefixes = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
      name = ["az-sub2","az-sub3","az-sub4"]
      
    }
  
}