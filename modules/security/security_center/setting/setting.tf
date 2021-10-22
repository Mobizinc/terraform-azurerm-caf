resource "azurerm_security_center_setting" "example" {
  setting_name        = var.setting_name
  enabled             = var.enabled
}