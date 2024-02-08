module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = var.remote_objects.private_endpoints
  depends_on = [azurerm_app_service_slot.slots]

  resource_id         = try(var.remote_objects.app_services[try(each.value.app_services.lz_key, var.client_config.landingzone_key)][each.value.app_services.key].id, null)
  location            = var.location
  name                = each.value.name
  resource_group_name = var.resource_group_name
  subnet_id           = try(var.remote_objects.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.remote_objects.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
  settings            = each.value
  global_settings     = var.global_settings
  base_tags           = var.base_tags
  private_dns         = var.private_dns
  client_config       = var.client_config
}

