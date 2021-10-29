module "security_center_assessment" {
  source     = "./modules/security/security_center/assessment"
  #for_each   = local.security.security_center_assessment
  count      = try(local.security.security_center_assessment, null) == null ? 0 : 1
  depends_on = [module.security_center_assessment_policy]

  assessment_policy_id = module.security_center_assessment_policy[local.security.security_center_assessment.assessment_policy].id
  target_resource_id   = local.combined_objects_virtual_machine_scale_sets[local.client_config.landingzone_key][local.security.security_center_assessment.target_resource].id
  code                 = local.security.security_center_assessment.status.code
}

module "security_center_assessment_policy" {
  source   = "./modules/security/security_center/assessment_policy"
  for_each = try(local.security.security_center_policy, {})

  settings = each.value
}

module "security_center_auto_provisioning" {
  source         = "./modules/security/security_center/auto_provisioning"
  count          = try(local.security.security_center_settings.auto_provision, null) == null ? 0 : 1

  auto_provision = try(local.security.security_center_settings.auto_provision, null)
}

module "security_center_contact" {
  source              = "./modules/security/security_center/contact"
  count               = try(local.security.security_center_settings.contact, null) == null ? 0 : 1

  email               = try(local.security.security_center_settings.contact.email, null)
  phone               = try(local.security.security_center_settings.contact.phone, null)
  alert_notifications = try(local.security.security_center_settings.contact.alert_notifications, null)
  alerts_to_admins    = try(local.security.security_center_settings.contact.alerts_to_admins, null)
}

module "security_center_setting" {
  source       = "./modules/security/security_center/setting"
  count        = try(local.security.security_center_settings.settings, null) == null ? 0 : 1

  setting_name = try(local.security.security_center_settings.settings.setting_name, null)
  enabled      = try(local.security.security_center_settings.settings.enabled, null)
}

module "security_center_subscription_pricing" {
  source        = "./modules/security/security_center/subscription_pricing"
  count         = try(local.security.security_center_subscription_pricing, null) == null ? 0 : 1

  tier          = try(local.security.security_center_subscription_pricing.tier, null)
  resource_type = try(local.security.security_center_subscription_pricing.resource_type, null)
}

module "security_center_automation" {
  source               = "./modules/security/security_center/automation"
  for_each             = try(local.security.security_center_automation, {})

  name                 = each.key
  settings             = each.value
  location             = try(local.global_settings.regions[each.value.region], local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location)
  resource_group_name  = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  event_hub            = local.combined_objects_event_hub
  event_hub_namespaces = local.combined_objects_event_hub_namespaces
  trigger_url          = local.combined_objects_logic_app_workflow #combined_objects_logic_app_trigger_http_request
  log_analytics        = local.combined_objects_log_analytics
  client_config        = local.client_config.landingzone_key
  subscriptions        = local.combined_objects_subscriptions
}