resource "azurecaf_name" "pls" {
  name          = var.name
  resource_type = "azurerm_private_link_service"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_private_link_service" "pls" {
  name                                        = azurecaf_name.pls.result
  location                                    = local.location
  resource_group_name                         = local.resource_group_name
  load_balancer_frontend_ip_configuration_ids = var.load_balancer_frontend_ip_configuration_ids
  auto_approval_subscription_ids              = try(var.auto_approval_subscription_ids, [])
  enable_proxy_protocol                       = try(var.enable_proxy_protocol, null)
  fqdns                                       = try(var.fqdns, null)
  visibility_subscription_ids                 = try(var.visibility_subscription_ids, [])
  tags                                        = local.tags

  dynamic "nat_ip_configuration" {
    for_each = var.settings.nat_ip_configuration

    content {
      name                       = lookup(nat_ip_configuration.value, "name", "default")
      subnet_id                  = can(nat_ip_configuration.value.subnet_id) ? nat_ip_configuration.value.subnet_id : var.networking[try(nat_ip_configuration.value.lz_key, local.client_config.landingzone_key)][nat_ip_configuration.value.vnet_key].subnets[nat_ip_configuration.value.subnet_key].id
      primary                    = nat_ip_configuration.value.primary
      private_ip_address         = try(nat_ip_configuration.value.private_ip_address, null)
      private_ip_address_version = try(nat_ip_configuration.value.private_ip_address_version, null)
    }
  }

}
