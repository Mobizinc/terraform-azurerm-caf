module "security_center_assessment_policy" {
  source   = "./modules/security/security_center/assessment_policy"
  for_each = local.security.security_center.policy

  settings            = each.value
  display_name        = each.key
}

module "security_center_auto_provisioning" {
  source   = "./modules/security/security_center/auto_provisioning"

  auto_provision      = local.security.security_center.auto_provision
}

module "security_center_contact" {
  source   = "./modules/security/security_center/contact"

  email               = local.security.security_center.email
  phone               = try(local.security.security_center.phone, {})
  alert_notifications = local.security.security_center.alert_notifications
  alerts_to_admins    = local.security.security_center.alerts_to_admins
}

module "security_center_setting" {
  source   = "./modules/security/security_center/setting"

  setting_name        = local.security.security_center.setting_name
  enabled             = local.security.security_center.enabled
}