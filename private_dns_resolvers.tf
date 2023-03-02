module "private_dns_resolvers" {
  source     = "./modules/networking/private_dns_resolvers"
  depends_on = [module.networking]
  for_each   = local.networking.private_dns_resolvers

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags : {}
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].id
  inbound_endpoint    = try(each.value.inbound_endpoint,  {})
  outbound_endpoint   = try(each.value.outbound_endpoint, {})
  remote_objects = {
    vnet_id =  try(
      local.combined_objects_networking[each.value.vnet.lz_key][each.value.vnet.key].id,
      local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet.key].id,
      null
    )
    vnets   = local.combined_objects_networking
  }

}
output "private_dns_resolvers" {
  value = module.private_dns_resolvers
}


module "private_dns_forwarding" {
  source     = "./modules/networking/private_dns_forwarding"
  depends_on = [module.networking,module.private_dns_resolvers]
  for_each   = local.networking.private_dns_forwarding

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags : {}
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].id
  outbound_endpoint   = try(local.combined_objects_private_dns_resolvers[try(each.value.private_dns_resolvers.lz_key, local.client_config.landingzone_key)][each.value.private_dns_resolvers.key].outbound_endpoint[each.value.private_dns_resolvers.outbound_endpoint_key].id, null)
  rulesets            = try(each.value.rulesets, {})
  virtualnetworklinks = try(each.value.virtualnetworklinks, {})
  remote_objects = {
    vnets  = local.combined_objects_networking
  }

}
output "private_dns_forwarding" {
  value = module.private_dns_forwarding
}