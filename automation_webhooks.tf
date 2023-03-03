module "automation_webhooks" {
  source   = "./modules/automation/automation_webhook"
  for_each = local.shared_services.automation_webhooks

  global_settings         = local.global_settings
  settings                = each.value
  resource_group_name     = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags               = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  client_config           = local.client_config
  automation_account_name = can(each.value.automation_account_name) ? each.value.automation_account_name : local.combined_objects_automations[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.automation_account_key].name
  runbook_name            = can(each.value.runbook_name) ? each.value.runbook_name : local.combined_objects_automation_runbooks[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.automation_runbook_key].name
}

output "automation_webhooks" {
  value = module.automation_webhooks
}
