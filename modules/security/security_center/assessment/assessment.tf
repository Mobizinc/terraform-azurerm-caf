resource "azurerm_security_center_assessment" "assessment" {
  assessment_policy_id = var.assessment_policy_id
  target_resource_id   = var.target_resource_id
  status {
    code = var.code
  }
}