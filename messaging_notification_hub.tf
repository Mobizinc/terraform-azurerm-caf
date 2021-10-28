module "notification_hub_namespaces" {
  source   = "./modules/messaging/notification_hub/notification_hub_namespace"
  for_each = local.messaging.notification_hub_namespaces

  settings            = each.value
  resource_group_name = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  location            = try(local.global_settings.regions[each.value.region], local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location)
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

output "notification_hub_namespace" {
  value = module.notification_hub_namespaces
}


module "notification_hub" {
  source   = "./modules/messaging/notification_hub/notification_hub"
  for_each = local.messaging.notification_hub

  settings            = each.value
  resource_group_name = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  location            = try(local.global_settings.regions[each.value.region], local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location)
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

output "notification_hub" {
  value = module.notification_hub
}

module "notification_hub_authorization_rule" {
  source   = "./modules/messaging/notification_hub/notification_hub_authorization_rule"
  for_each = local.messaging.notification_hub_authorization_rule

  settings            = each.value
  resource_group_name = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  
}