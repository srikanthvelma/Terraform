AZ - Vnet Module 
----------------
### Variables required to use this module

* VAR types used are
* `rg_info type: object`
* `vnet_info type: object`
* default values as follws, kindly change as per your requirement
```s
rg_info = {
      location = "East US"
      name = "az-rg"
    }
    vnet_info = {
      address_space = "192.168.0.0/16"
      name = "az-vnet"
    }
```