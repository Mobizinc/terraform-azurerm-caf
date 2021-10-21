module "security_center_assessment_policy" {
  source   = "./modules/security/security_center/security_center_assessment_policy"
  for_each = local.security.security_center_assessment_policy

  settings            = each.value
  display_name        = each.key
}