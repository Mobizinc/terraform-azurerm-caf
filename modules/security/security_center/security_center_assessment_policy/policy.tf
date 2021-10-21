resource "azurerm_security_center_assessment_policy" "example" {
  display_name = var.display_name
  severity     = var.settings.severity
  description  = var.settings.description
}