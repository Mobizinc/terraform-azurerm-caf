resource "azurerm_security_center_subscription_pricing" "subscription_pricing" {
  tier          = var.tier
  resource_type = var.resource_type
}