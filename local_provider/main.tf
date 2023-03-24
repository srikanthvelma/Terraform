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
    filename = "D:/TRAINING/JIOP/Terraform/test.txt"

  }

