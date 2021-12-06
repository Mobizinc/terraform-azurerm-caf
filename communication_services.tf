module "communication_services" {
  source               = "./modules/communication_services"
  for_each             = local.communication_services.communication_services
  
  global_settings      = local.global_settings
  settings             = each.value
  resource_group_name  = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  diagnostics          = local.combined_diagnostics
  location             = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
}