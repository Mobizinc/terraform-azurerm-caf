module "container_groups" {
  source     = "./modules/compute/container_group"
  for_each   = local.compute.container_groups
  depends_on = [module.dynamic_keyvault_secrets]

  base_tags                  = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].tags : {}
  client_config              = local.client_config
  combined_diagnostics       = local.combined_diagnostics
  diagnostic_profiles        = try(each.value.diagnostic_profiles, {})
  global_settings            = local.global_settings
  location                   = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name        = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  settings                   = each.value
  dynamic_keyvault_secrets   = try(local.security.dynamic_keyvault_secrets, {})
  storage_account_name       = try(data.azurerm_storage_account.storage_accounts[each.key].name, null)
  storage_account_access_key = try(data.azurerm_storage_account.storage_accounts[each.key].primary_access_key, null)
  combined_resources = {
    keyvaults          = local.combined_objects_keyvaults
    managed_identities = local.combined_objects_managed_identities
    network_profiles   = local.combined_objects_network_profiles
  }
}

data "azurerm_storage_account" "storage_accounts" {
  for_each = {
    for key, value in local.compute.container_groups : key => value
    if try(value.storage_account_key, null) != null
  }

  name                = module.storage_accounts[each.value.storage_account_key].name
  resource_group_name = module.storage_accounts[each.value.storage_account_key].resource_group_name
}
    
module "network_profiles" {
  source   = "./modules/networking/network_profile"
  for_each = local.networking.network_profiles

  base_tags       = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags : {}
  client_config   = local.client_config
  global_settings = local.global_settings
  settings        = each.value
  resource_group  = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]

  remote_objects = {
    networking      = local.combined_objects_networking
    virtual_subnets = local.combined_objects_virtual_subnets
  }
}

output "container_groups" {
  value = module.container_groups
}

