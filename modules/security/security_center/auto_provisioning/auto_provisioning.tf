resource "azurerm_security_center_auto_provisioning" "example" {
  auto_provision      = try (var.auto_provision, null)
}