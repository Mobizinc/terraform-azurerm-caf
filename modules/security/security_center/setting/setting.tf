resource "azurerm_security_center_setting" "setting" {
  setting_name = var.setting_name
  enabled      = var.enabled
}