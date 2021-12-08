resource "azurerm_template_deployment" "aks_proxy" {
  


  name                = var.settings.name
  resource_group_name = var.resource_group_name

  template_body = file(local.arm_filename)

  parameters = {
    "existingVirtualNetworkResourceGroup" = var.resource_group_name
    "httpProxy" = var.settings.httpProxy
    "httpsProxy" = var.settings.httpsProxy
    "vnetSubnetID" = var.subnet_id
    "existingSubnetName"  = var.subnet_name
    "existingVirtualNetworkName" =  var.remote_virtual_network_id
    
  }

  deployment_mode = "Incremental"
}