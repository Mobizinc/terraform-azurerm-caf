terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}
locals {

  arm_filename = "${path.module}/aks.json"
} 
