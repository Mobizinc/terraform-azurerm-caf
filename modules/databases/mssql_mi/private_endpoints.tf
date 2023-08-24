module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = var.remote_objects.private_endpoints

  resource_id         = azurerm_mssql_managed_instance.mssqlmi.id
  location            = var.location
  name                = each.value.name
  resource_group_name = var.resource_group_name
  subnet_id           = try(var.remote_objects.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.remote_objects.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
  settings            = each.value
  global_settings     = var.global_settings
  tags                = local.tags
  base_tags           = local.global_settings.inherit_tags
  private_dns         = var.remote_objects.private_dns
  client_config       = var.client_config
}
