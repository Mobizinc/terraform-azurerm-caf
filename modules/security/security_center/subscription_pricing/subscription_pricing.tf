resource "azurerm_security_center_subscription_pricing" "example" {
  tier          = var.tier
  resource_type = var.resource_type
}