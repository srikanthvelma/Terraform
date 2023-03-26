terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

resource "local_file" "test" {
  content  = "Hello This is from Terraform"
  filename = "D:/TRAINING/JIOP/Terraform/azure/test1.txt"

}

output "content" {
    value = local_file.test.content
  
}