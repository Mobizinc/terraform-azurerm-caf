resource "azurerm_express_route_circuit_authorization" "circuitauth" {
  name                       = var.settings.name
  express_route_circuit_name = var.express_route_circuit_name
  resource_group_name        = var.resource_group_name
  lifecycle {
    ignore_changes = [
      resource_group_name, express_route_circuit_name
    ]
  }
}
