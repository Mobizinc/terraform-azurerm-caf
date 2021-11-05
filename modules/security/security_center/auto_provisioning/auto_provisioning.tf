resource "azurerm_security_center_auto_provisioning" "auto_provision" {
  auto_provision = try(var.auto_provision, null)
}