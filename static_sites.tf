# Tested with : 2.99.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/

module "static_sites" {
  source   = "./modules/webapps/static_site"
  for_each = local.webapp.static_sites

  name                = each.value.name
  client_config       = local.client_config
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  resource_groups     = local.combined_objects_resource_groups
  sku_size            = try(each.value.sku_size, null)
  sku_tier            = try(each.value.sku_tier, null)
  identity            = try(each.value.identity, null)
  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  diagnostic_profiles = try(each.value.diagnostic_profiles, null)
  diagnostics         = local.combined_diagnostics
  tags                = try(each.value.tags, null)
  application_insight = try(each.value.application_insight_key, null) == null ? null : module.azurerm_application_insights[each.value.application_insight_key]
  api_token_name      = try(each.value.api_token_name, null)
  custom_domains      = try(each.value.custom_domains, {})
  remote_objects = {
    subnets            = try(local.combined_objects_networking[try(each.value.settings.lz_key, local.client_config.landingzone_key)][each.value.settings.vnet_key].subnets, null)
    resource_groups    = try(each.value.private_endpoints, {}) == {} ? null : local.resource_groups
    private_dns        = local.combined_objects_private_dns
    vnets              = local.combined_objects_networking
    private_endpoints  = try(each.value.private_endpoints, {})
    keyvault_id        = can(each.value.keyvault.key) ? local.combined_objects_keyvaults[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][each.value.keyvault.key].id : null
    }
}

output "static_sites" {
  value = module.static_sites
}
