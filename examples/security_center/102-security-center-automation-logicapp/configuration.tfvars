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

logic_app_workflow = {
  applogic1 = {
    name               = "workflow1"
    region             = "region1"
    resource_group_key = "rgwflow1"
    workflow_version = "1.0.0.0"
  }
}

logic_app_trigger_http_request = {
  trigger_http_request1 = {
    name          = "webhook"
    logic_app_key = "applogic1"
    schema        = <<SCHEMA
{
    "type": "object",
    "properties": {
        "hello": {
            "type": "string"
        }
    }
}
SCHEMA
  }
}

security_center_automation = {
  aut1 = {
      resource_group_key = "evh_examples"
      action = {
          action1 = {
          type         = "LogicApp"
          resource_id  = "applogic1"
          }
          action2 = {
          type         = "LogicApp"
          resource_id  = "applogic1"
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