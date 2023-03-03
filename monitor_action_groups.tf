module "monitor_action_groups" {
  source                               = "./modules/monitoring/monitor_action_group"
  for_each                             = local.shared_services.monitor_action_groups
  global_settings                      = local.global_settings
  settings                             = each.value
  resource_group_name                  = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  client_config                        = local.client_config
  combined_objects_automations         = local.combined_objects_automations
  combined_objects_automation_runbooks = local.combined_objects_automation_runbooks
  combined_objects_automation_webhooks = local.combined_objects_automation_webhooks
}

output "monitor_action_groups" {
  value = module.monitor_action_groups
}
