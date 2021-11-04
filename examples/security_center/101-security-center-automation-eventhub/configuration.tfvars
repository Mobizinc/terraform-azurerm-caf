global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  evh_examples = {
    name = "evh_examples"
  }
}


event_hub_namespaces = {
  evh1 = {
    name               = "evh1"
    resource_group_key = "evh_examples"
    sku                = "Standard"
    region             = "region1"
  }
}

event_hubs = {
  ev = {
    name                    = "ev"
    resource_group_key      = "evh_examples"
    event_hub_namespace_key = "evh1"
    storage_account_key     = "evh1"
    blob_container_name     = "evh"
    partition_count         = "2"
    message_retention       = "2"
  }
}

event_hub_auth_rules = {
  rule1 = {
    resource_group_key      = "evh_examples"
    event_hub_namespace_key = "evh1"
    event_hub_name_key      = "ev"
    rule_name               = "ev-rule"
    listen                  = true
    send                    = true
    manage                  = false
  }
}

security_center_automation = {
  aut1 = {
      resource_group_key = "evh_examples"
      action = {
          action1 = {
          type         = "EventHub"
          resource_id  = "evh1"
          connection_string = "siem"
          }
          action2 = {
          type         = "EventHub"
          resource_id  = "evh1"
          connection_string = "siem"
          }
      }
      source = {
        event_source = "Alerts"
        rule_set = {
          rule1 = {
            property_path  = "properties.metadata.severity"
            operator       = "Equals"
            expected_value = "High"
            property_type  = "String"
          }
          rule2 = {
            property_path  = "properties.metadata.severity"
            operator       = "Contains"
            expected_value = "High"
            property_type  = "Boolean"
          }
        }
      }
      scopes = {
        subscription = {
          key    = ""
          lz_key = "" # optional
          id     = "/subscriptions/7b822bcb-9762-46f6-8877-d5b0212572ce"
        }
      }
  }
}