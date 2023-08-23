output "postgresql_flexible_servers" {
  value = module.postgresql_flexible_servers
}

module "postgresql_flexible_servers" {
  source     = "./modules/databases/postgresql_flexible_server"
  depends_on = [module.keyvaults, module.networking]
  for_each   = local.database.postgresql_flexible_servers

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  resource_group  = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)]
  base_tags       = local.global_settings.inherit_tags

  remote_objects = {
    subnet_id           = can(each.value.vnet.subnet_key) ? local.combined_objects_networking[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][each.value.vnet.key].subnets[each.value.vnet.subnet_key].id : null
    private_dns_zone_id = can(each.value.private_dns_zone.key) ? local.combined_objects_private_dns[try(each.value.private_dns_zone.lz_key, local.client_config.landingzone_key)][each.value.private_dns_zone.key].id : null
    keyvault_id         = can(each.value.keyvault.key) ? local.combined_objects_keyvaults[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][each.value.keyvault.key].id : null
    diagnostics         = local.combined_diagnostics
  }
}

output "postgresql_flexible_servers_v2" {
  value = module.postgresql_flexible_servers_v2
}

module "postgresql_flexible_servers_v2" {
  source     = "./modules/databases/postgresql_flexible_server_v2"
  depends_on = [module.keyvaults, module.networking]
  for_each   = local.database.postgresql_flexible_servers_v2

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].id

  remote_objects = {
    subnet_id = try(
      local.combined_objects_networking[each.value.vnet.lz_key][each.value.vnet.key].subnets[each.value.vnet.subnet_key].id,
      local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet.key].subnets[each.value.vnet.subnet_key].id,
      null
    )

    private_dns_zone_id = try(
      local.combined_objects_private_dns[each.value.private_dns_zone.lz_key][each.value.private_dns_zone.key].id,
      local.combined_objects_private_dns[local.client_config.landingzone_key][each.value.private_dns_zone.key].id,
      null
    )

    keyvault_id = try(
      local.combined_objects_keyvaults[each.value.keyvault.lz_key][each.value.keyvault.key].id,
      local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault.key].id,
      null
    )

    diagnostics = local.combined_diagnostics
  }
}
