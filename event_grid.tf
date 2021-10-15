module "event_grid_topic" {
  source   = "./modules/event_grid/topic"
  for_each = try(var.event_grid_topic, {})

  resource_group_name = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  location            = try(local.global_settings.regions[each.value.region], local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location)
  settings            = each.value
  topic_name          = each.key
}