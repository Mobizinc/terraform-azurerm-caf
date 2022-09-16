module "private_link_service" {
  source   = "../networking/private_link_service"
  for_each = var.private_link_service

  name                = each.value.name
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  settings            = each.value
  global_settings     = local.global_settings
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  client_config       = local.client_config
  networking          = local.combined_objects_networking

  load_balancer_frontend_ip_configuration_ids = can(each.value.load_balancer_frontend_ip_configuration_ids) ? each.value.load_balancer_frontend_ip_configuration_ids : local.combined_objects_lb[try(each.value.load_balancer_frontend_ip_configuration.lz_key, local.client_config.landingzone_key)][each.value.load_balancer_frontend_ip_configuration.lb_key].frontend_ip_configuration.id
  auto_approval_subscription_ids              = try(each.value.auto_approval_subscription_ids, [])
  enable_proxy_protocol                       = try(each.value.enable_proxy_protocol, null)
  fqdns                                       = try(each.value.fqdns, null)
  visibility_subscription_ids                 = try(each.value.visibility_subscription_ids, [])

}
