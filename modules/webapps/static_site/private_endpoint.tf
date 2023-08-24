module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = var.remote_objects.private_endpoints

  resource_id         = azurerm_static_site.static_site.id
  location            = var.location
  name                = each.value.name
  resource_group_name = var.resource_groups[try(each.value.resource_group.lz_key, var.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  subnet_id           = try(var.remote_objects.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.remote_objects.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
  settings            = each.value
  global_settings     = var.global_settings
  tags                = local.tags
  base_tags           = var.global_settings.inherit_tags
  private_dns         = var.remote_objects.private_dns
  client_config       = var.client_config
}
