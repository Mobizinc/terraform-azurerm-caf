resource "time_sleep" "static_webapps" {
  depends_on = [azurerm_resource_group_template_deployment.example]
  
  create_duration  = "30s"
  destroy_duration = "30s"
}

module "private_endpoint" {
  depends_on = [time_sleep.static_webapps]
  source   = "../../networking/private_endpoint"
  for_each = var.remote_objects.private_endpoints

  resource_id         = format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Web/staticSites/%s", data.azurerm_subscription.current.subscription_id, var.resource_group_name, var.name)
  location            = var.location
  name                = each.value.name
  resource_group_name = var.resource_group_name
  subnet_id           = try(var.remote_objects.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.remote_objects.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
  settings            = each.value
  global_settings     = var.global_settings
  base_tags           = var.base_tags
  private_dns         = var.remote_objects.private_dns
  client_config       = var.client_config
}
