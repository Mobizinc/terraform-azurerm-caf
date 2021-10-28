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


# event_hub_namespaces = {
#   evh1 = {
#     name               = "evh1"
#     resource_group_key = "evh_examples"
#     sku                = "Standard"
#     region             = "region1"
#   }
# }

# event_hubs = {
#   ev = {
#     name                    = "ev"
#     resource_group_key      = "evh_examples"
#     event_hub_namespace_key = "evh1"
#     storage_account_key     = "evh1"
#     blob_container_name     = "evh"
#     partition_count         = "2"
#     message_retention       = "2"
#   }
# }

# event_hub_auth_rules = {
#   rule1 = {
#     resource_group_key      = "evh_examples"
#     event_hub_namespace_key = "evh1"
#     event_hub_name_key      = "ev"
#     rule_name               = "ev-rule"
#     listen                  = true
#     send                    = true
#     manage                  = false
#   }
# }

# logic_app_workflow = {
#   applogic1 = {
#     name               = "workflow1"
#     region             = "region1"
#     resource_group_key = "rgwflow1"
#     #integration_service_environment_key
#     #logic_app_integration_account_key
#     #workflow_parameters
#     #workflow_schema
#     workflow_version = "1.0.0.0"
#     #parameters
#   }
# }

# logic_app_trigger_http_request = {
#   trigger_http_request1 = {
#     name          = "webhook"
#     logic_app_key = "applogic1"
#     schema        = <<SCHEMA
# {
#     "type": "object",
#     "properties": {
#         "hello": {
#             "type": "string"
#         }
#     }
# }
# SCHEMA
#   }
# }

# security_center_settings = {
#     auto_provision      = "On"
#     settings = {
#       setting_name        = "MCAS"
#       enabled             = "true"
#     }
#     contact = {
#       email               = "contact@example.com"
#       phone               = "+1-555-555-5555"
#       alert_notifications = "true"
#       alerts_to_admins    = "true"
#     }
# }

# security_center_assessment = {

#       status = {
#         code = "Healthy"
#       }

# }

# security_center_policy = {
#   asp_example1 = {
#     name    = "asp_example1"
#     severity = "Medium"
#     description = "This is test 1"
#   }
#   asp_example2 ={
#     name     = "asp_example2"
#     severity = "High"
#     description = "This is test 2"
#   }  
# }

# security_center_subscription_pricing = {
#   tier          = "Standard"
#   resource_type = "VirtualMachines"
# }

security_center_automation = {
        aut1 = {
            resource_group_key = "evh_examples"
            action = {
                action1 = {
                type         = "EventHub"
                resource_id  = "ev"
                }
                action2 = {
                type         = "EventHub"
                resource_id  = "ev"
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
        }

      #  aut2 = {
      #     type = "logic_app"
      #      resource_key = "logicapp_example"
      #  }

}