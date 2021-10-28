resource "azurerm_security_center_assessment_policy" "policy" {
  display_name = var.settings.name
  severity     = var.settings.severity
  description  = var.settings.description
}