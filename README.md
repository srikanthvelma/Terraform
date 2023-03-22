Terraform Course Notes
-----------------------
* Any organization needs Infrastructure to build and deploy the application into different environments (Dev,QA,UAT,Staging,Production).
* The Architecture required for a normal application 
  ![preview](images/tf1.png)
* Infra required for above is
  * Two networks with connectivity b/w them (same building, different buildings, cities, countries)
  * in each network
    * 2 databases
      * mysql
      * RAM: 8 GB
      * cpus: 2
      * Disk: 10 TB
    * 1 file store
      * size :10TB
    * 3 servers
      * OS: UBUNTU 22.04
      * RAM : 16GB
      * Cpus: 2
      * Disk: 50GB
* To create this infra - we required InfraProvisioning tools
* **InfraProvisioning**: This represents using Infrastructure as a Code and deploy to target environment
* We use InfraProvisioing tools where we express our desired state about infrastructure as code.
### Understanding InfraProvisoning
![preview](images/tf2.png)
![preview](images/tf3.png)
* **Terraform**: Can create infra in almost all the virtual environments using IaC(Infrastructure as code).
* ARM Templates: Can create infra in Azure
* Cloudformation: Can create infra in AWS
* Infraprovisiong tools use IaC which are generally idempotent
* **Idempotance** is the property which states execution one time or multiple times leads to the same result.
* Reusability is extreemely simple and terraform can also handle multiple environments (Developer, QA, UAT/Staging/Production).

## Terraform
* Terraform is an opensource tool developed by HashiCorp which can create infra in almost any virtual platform
* Terraform uses a language which is called as Hashicorp Configuration Language (HCL) to express desired State.
### Terms
* Resource: This is the infrastructure which you want to create
* Provider: This refers to where you want to create infrastructure
* arguments: The inputs which we express in teraform are called as arguments
* attribute: The output given by terraform is referred as attribute
### Installing Terraform
* [referhere](https://developer.hashicorp.com/terraform/downloads)



### Azure Provider
* To install azure cli [refer](https://learn.microsoft.com/en-us/cli/azure/)
* After installing cli ,we have to config cli where ever we need it, for terraform i have configured in my system and also we have know the process for linux m/c
* To config azure cli `az login` => it will redirect to microsoft web page then we have select our azure account id, then it will configured automatically
* To check authentication done or not we can check by command `az group list` which will show the resource groups list
* for terraform to work with ,we need to config provider first
* Azure provider [refer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
* Azure provider syntax
```t
# if we required particular version of provider below terraform block is req
terraform {
required_providers {
  azurerm = {
    source  = "hashicorp/azurerm"
    version = "=3.0.0"
    }
  }
}

# normally if we start with below provider blcok directly
provider "azurerm" {
  feature {}
}
```
* Azure Resource syntax
```t
resource "type of resource" "resource name" {    # type of resource could be provide_resourcetype
  arg 1 = val 1
  arg 2 = val 2
}

# create a resource group
resource "azurerm_resource_group" "workshop" {
  name = "workshop"
  location = "East US"
}

```
### VPC Creation in AWS through terraform
* Manual inputs for vpc creation
* `Name tag : "ntiervpc"`
* `cidr_block : "192.168.0.0/24`
* Lets create it from terraform
* first create terraform template `main.tf` in specific folder ex: /aws/vpc
```t
provider "aws" {
  region = "ap-south-1"

}

resource "aws_vpc" "app" {
  cidr_block = "192.168.0.0/16"

  tags = {
    "Name" = "app1"
  }

}
```
* `terraform init`    # to config terraform and provider
![preview](images/tf10.png)
![preview](images/tf11.png)
* `terraform validate`  # to validate the syntax
![preview](images/tf12.png)
* `terraform apply`     # to run template tasks (creating, modifying)
![preview](images/tf13.png)
![preview](images/tf14.png)
![preview](images/tf15.png)
![preview](images/tf16.png)
* `terraform destroy`  # to delete the created resources from terraform
![preview](images/tf17.png)
![preview](images/tf18.png)
![preview](images/tf19.png)

### Creation of vnet in azure through terraform
* Manual requirements
  * resource group
    * `name = "vnetgroup"`
    * `location = "East US"`
  * vnet
    * `name = "vnet1"`
    * `resource_group_name = "vnetgroup"`
    * `location = "East US"`
    * `address_space = ["192.168.0.0/16"]`
  * subnet
    * `name = "appsubnet1"`
    * `address_prefix = "192.168.0.0/24"`
* lets create a vnet from terraform template
``` t
provider "azurerm" {
  features {}

}

resource "azurerm_resource_group" "vnet" {
  name     = "vnetgroup"
  location = "East US"

}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  resource_group_name = "vnetgroup"
  location            = "East US"
  address_space       = ["192.168.0.0/16"]

  subnet {
    address_prefix = "192.168.1.0/24"
    name           = "appsubnet"
  }
  
  depends_on = [                  # depends_on Meta argument in terraform ,used for dependecy of task
    azurerm_resource_group.vnet
  ]
}
```
```t
terraform init
terraform fmt
terraform validate
terraform apply -auto-approve
terraform destroy
```
![preview](images/tf20.png)
![preview](images/tf21.png)
![preview](images/tf22.png)
![preview](images/tf23.png)
![preview](images/tf24.png)
![preview](images/tf25.png)
![preview](images/tf26.png)

* To Work effectively with terrform templates we need to understand Hashicorp Configuration Language
### Hashicorp Configuration Language (HCL) for Terraform
* For specification [referhere](https://github.com/hashicorp/hcl/blob/main/hclsyntax/spec.md)
* 