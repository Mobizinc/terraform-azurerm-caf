resource "azurerm_security_center_contact" "contact" {
  email               = var.email
  phone               = var.phone
  alert_notifications = var.alert_notifications 
  alerts_to_admins    = var.alerts_to_admins
}