module "private_endpoint" {
  depends_on = [azurerm_api_management.apim]
  source   = "../../networking/private_endpoint"
  for_each = var.remote_objects.private_endpoints

  resource_id     = azurerm_api_management.apim.id
  location        = var.location
  name            = each.value.name
  resource_group_name = var.resource_group_name
  subnet_id       = try(var.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
  settings        = each.value
  global_settings = var.global_settings
  base_tags       = var.base_tags
  private_dns     = var.remote_objects.private_dns
  client_config   = var.client_config
}
