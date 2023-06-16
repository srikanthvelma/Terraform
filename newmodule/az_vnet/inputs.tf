variable "azres" {
    type = object({
      name = string
      location = string
    })
    default = {
      name = "az_resource"
      location = "East Us"
    }
}