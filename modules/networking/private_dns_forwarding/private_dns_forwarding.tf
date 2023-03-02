
resource "azapi_resource" "ruleset" {
  type      = "Microsoft.Network/dnsForwardingRulesets@2022-07-01"
  name      = var.settings.name
  location  = var.location
  parent_id = var.resource_group_name
  tags = merge(local.tags, lookup(var.settings, "tags", {}))

  body = jsonencode({
    properties = {
      dnsResolverOutboundEndpoints = [{
        id = try(var.outbound_endpoint, var.settings.outbound_endpoint_id)
      }]
    }
  })

}

resource "azapi_resource" "forwardingRules" {
  for_each   = var.rulesets
  type       = "Microsoft.Network/dnsForwardingRulesets/forwardingRules@2022-07-01"
  name       = each.value.name
  parent_id  = azapi_resource.ruleset.id
  body = jsonencode({
    properties = {
      domainName = each.value.domain_name
      forwardingRuleState = try(each.value.forwardingrulestate, "Enabled")
      metadata = try(each.value.metadata, {})
      targetDnsServers = [
        {
          ipAddress = each.value.ipdddress
          port      = tonumber(each.value.port)
        }
      ]
    }
  })
}

resource "azapi_resource" "virtualNetworkLinks" {
  for_each   = var.virtualnetworklinks
  type       = "Microsoft.Network/dnsForwardingRulesets/virtualNetworkLinks@2022-07-01"
  name       = each.value.name
  parent_id  = azapi_resource.ruleset.id
  body = jsonencode({
    properties = {
      metadata = {}
      virtualNetwork = {
        id = try(
          var.remote_objects.vnets[var.client_config.landingzone_key][each.value.vnet_key].id,
          var.remote_objects.vnets[each.value.lz_key][each.value.vnet_key].id,
          each.value.vnet_id,
          null
        )
      }
    }
  })
}