
module "static_webapps" {
  source     = "./modules/webapps/static_webapps"
  depends_on = [module.networking]
  for_each   = local.webapp.static_webapps

  name                 = each.value.name
  client_config        = local.client_config
  location             = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name  = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  settings             = each.value
  identity             = try(each.value.identity, null)
  global_settings      = local.global_settings
  base_tags            = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags : {}
  tags                 = try(each.value.tags, null)
  dynamic_app_settings = try(each.value.dynamic_app_settings, {})
  combined_objects     = local.dynamic_app_settings_combined_objects
  remote_objects = {
    subnets = try(local.combined_objects_networking[try(each.value.settings.lz_key, local.client_config.landingzone_key)][each.value.settings.vnet_key].subnets, null)
    private_dns        = local.combined_objects_private_dns
    vnets              = local.combined_objects_networking
    private_endpoints  = try(each.value.private_endpoints, {})
  }  
}

output "static_webapps" {
  value = module.static_webapps
}

