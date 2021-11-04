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

log_analytics = {
  law1 = {
    #location            = "region1"
    name               = "securitycenterworkspaceexample"
    resource_group_key = "evh_examples"
  }
}

security_center_automation = {
  aut1 = {
      resource_group_key = "evh_examples"
      action = {
          action1 = {
          type         = "LogAnalytics"
          resource_id  = "law1"
          }
          action2 = {
          type         = "LogAnalytics"
          resource_id  = "law1"
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