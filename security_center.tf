module "security_center_assessment_policy" {
  source   = "./modules/security/security_center/assessment_policy"

  for_each = try(local.security.security_center.policy, {})

  settings            = each.value
  display_name        = each.key
}

module "security_center_auto_provisioning" {
  source   = "./modules/security/security_center/auto_provisioning"

  auto_provision      = try(local.security.security_center.auto_provision, {})
}

module "security_center_contact" {
  source   = "./modules/security/security_center/contact"

    count = try(local.security.security_center.contact, null) == null ? 0 : 1

  email               = try(local.security.security_center.contact.email, null)
  phone               = try(local.security.security_center.contact.phone, null)
  alert_notifications = try(local.security.security_center.contact.alert_notifications, null)
  alerts_to_admins    = try(local.security.security_center.contact.alerts_to_admins, null)
}

module "security_center_setting" {
  source   = "./modules/security/security_center/setting"

  count = try(local.security.security_center.settings, null) == null ? 0 : 1

  setting_name        = try(local.security.security_center.settings.setting_name, null)
  enabled             = try(local.security.security_center.settings.enabled, null)
}