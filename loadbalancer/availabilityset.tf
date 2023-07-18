# resource "azurerm_availability_set" "vmset" {
#     count = var.vms
#     name = "availabilityset-${count.index}"
#     resource_group_name = var.narmada.name
#     location = var.az_location[count.index]
#     tags = {
#       "env" = "dev"
#     }
# }
