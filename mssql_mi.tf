module "mssql_mi" {
  source     = "./modules/databases/mssql_mi"
  for_each   = local.database.mssql_mi
  depends_on = [module.keyvaults, module.networking]

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  subnet_id       = can(each.value.networking.subnet_id) ? each.value.networking.subnet_id : local.combined_objects_networking[try(each.value.networking.lz_key, local.client_config.landingzone_key)][each.value.networking.vnet_key].subnets[each.value.networking.subnet_key].id
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  identity            = try(each.value.identity, null)
  
  keyvault_id = coalesce(
    try(each.value.administrator_password, null),
    try(module.keyvaults[each.value.keyvault_key].id, null),
    try(local.combined_objects_keyvaults[each.value.keyvault.lz_key][each.value.keyvault.key].id, null),
    try(local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault.key].id, null)
  )
}

output "mssql_mi" {
  value = module.mssql_mi

}