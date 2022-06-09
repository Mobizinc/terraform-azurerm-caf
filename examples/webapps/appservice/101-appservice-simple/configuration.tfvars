global_settings = {
  default_region = "region2"
  regions = {
    region1 = "australiaeast"
  }
}

# resource_groups = {
#   webapp_extend = {
#     name   = "webapp-extend"
#     region = "region2"
#   }
# }

# # By default asp1 will inherit from the resource group location
# app_service_plans = {
#   asp_extend = {
#     resource_group_key = "webapp_extend"
#     name               = "asp-extend"

#     sku = {
#       tier = "Standard"
#       size = "S1"
#     }
#   }
# }
# azurerm_application_insights = {
#   tfvars = {
#     name               = "tfvars-geenrator-api-ai"
#     resource_group_key = "webapp_extend"
#     application_type   = "web"
#   }
# }
# app_services = {
#   webapp1 = {
#     resource_group_key   = "webapp_extend"
#     name                 = "webapp-extend"
#     app_service_plan_key = "asp_extend"
#     application_insight_key = "tfvars"
#     identity = {
#       type = "SystemAssigned"
#     }
#     app_settings = {
#          "ENABLE_ORYX_BUILD"              = "true"
#          "SCM_DO_BUILD_DURING_DEPLOYMENT" = "1"
#          "WEBSITE_VNET_ROUTE_ALL"         = "1"
#          "WEBSITE_WEBDEPLOY_USE_SCM"      = "true"
#          "github_organization"            = "Mobizinc"
#          "projects_folder"                = "projects"
#          "respository_name"               = "alz-caf-tf"
#          "PAT"                            = "@Microsoft.KeyVault(VaultName=kvlaunchpad-ops-prod-re2;SecretName=tfvargithubpat)"
#      }
     
#     settings = {
#       enabled                 = true
#       numberOfWorkers         = 2
#       client_affinity_enabled = false
#       client_cert_enabled     = false
#       https_only              = true

#       site_config = {
#         default_documents        = ["main.aspx"]
#         always_on                = true
#         dotnet_framework_version = "v4.0"
#         app_command_line         = null         ///sbin/myserver -b 0.0.0.0
#         ftps_state               = "AllAllowed" //AllAllowed, FtpsOnly and Disabled
#         http2_enabled            = false

#       }



#       tags = {
#         Department = "IT"
#       }
#     }
#   }
# }


resource_groups = {
  webapp_simple = {
    name   = "webapp-simple"
    region = "region2"
  }
}

static_webapps = {
  example_1 = {
    resource_group_key   = "webapp_simple"
    name                 = "static-webapps-vk"
    sku                  = "Standard" 
     

    github_repo = "https://github.com/onlyillusion/actions.git"
    github_branch = "main"
    github_token  = "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"
            private_endpoints = {
    # Require enforce_private_link_endpoint_network_policies set to true on the subnet
            f1 = {
              #resource_id        = "/subscriptions/158d9f92-ec1e-433e-8388-6f7157282c13/resourceGroups/lnio-rg-webapp-simple-gcy/providers/Microsoft.Web/staticSites/static-webapps-vk"
              name               = "static-webapps-vk-pe"
              vnet_key           = "spoke"
              subnet_key         = "app"
              resource_group_key = "webapp_simple"
              #lz_key             = "launchpad-ops-prod-re2-networking_spoke"
              private_service_connection = {
                name                 = "static-webapps-vk-psc"
                is_manual_connection = false
                subresource_names    = ["staticSites"]
              }
              private_dns = {
                zone_group_name = "default"
              #  lz_key          = "privatedns"   # If the DNS keys are deployed in a remote landingzone
                keys = ["web_dns"]
              }
        }
      } 
  }
}

# app_service_plans = {
#   asp2 = {
#     resource_group_key = "webapp_simple"
#     name               = "test-asp-vk"
#     reserved           = "true"
#     kind               = "Linux"
#     sku = {
#       tier = "Basic"
#       size = "P3v2"
#     }
#   }
# }
# azurerm_application_insights = {
#   tfvars = {
#     name               = "tfvars-geenrator-api-ai"
#     resource_group_key = "webapp_simple"
#     application_type   = "web"
#   }
# }
# app_services = {
#   webapp1 = {
#     resource_group_key   = "webapp_simple"
#     name                 = "iqwebapp-simplevk"
#     app_service_plan_key = "asp2"
#     https_only           = "true"
#     application_insight_key = "tfvars"
 
#     # vnet_integration = {
#     #   vnet_key   = "spoke"
#     #   subnet_key = "app1"
#     #   #lz_key     = "launchpad-ops-prod-re2-networking_spoke"
#     # }

#     app_settings = {
#         "ENABLE_ORYX_BUILD"              = "true"
#         "SCM_DO_BUILD_DURING_DEPLOYMENT" = "1"
#         "WEBSITE_VNET_ROUTE_ALL"         = "1"
#         "WEBSITE_WEBDEPLOY_USE_SCM"      = "true"
#         "github_organization"            = "Mobizinc"
#         "projects_folder"                = "projects"
#         "respository_name"               = "alz-caf-tf"
#         "TEST"                           = "TWST"
#     }

#     settings = {
#       enabled = "true"
    
#       site_config = {
#         linux_fx_version           = "PYTHON|3.9"
#         always_on                  = "true"
#         ftps_state                 = "Disabled"
        
#     }
#     }
#     # private_endpoints = {
#     # # Require enforce_private_link_endpoint_network_policies set to true on the subnet
#     #         f1 = {
#     #           name               = "iqwebapp-simple-pe"
#     #           vnet_key           = "spoke"
#     #           subnet_key         = "app"
#     #           resource_group_key = "webapp_simple"
#     #           #lz_key             = "launchpad-ops-prod-re2-networking_spoke"
#     #           private_service_connection = {
#     #             name                 = "iqwebapp-simple-psc"
#     #             is_manual_connection = false
#     #             subresource_names    = ["sites"]
#     #           }

#     #     }
#     #   }
#   }
# }


vnets = {
  spoke = {
    resource_group_key = "webapp_simple"
    region             = "region2"
    vnet = {
      name          = "spoke"
      address_space = ["10.1.0.0/24"]
    }
    specialsubnets = {}
    subnets = {
      app = {
        name = "app"
        cidr = ["10.1.0.0/25"]
        enforce_private_link_endpoint_network_policies = true
      }
      app1 = {
        name = "scope"
        cidr = ["10.1.0.128/26"]
        delegation = {
          name               = "serverFarms"
          service_delegation = "Microsoft.Web/serverFarms"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/action"
          ]
        }
      }

    }

  }

}

 private_dns = {

  web_dns = {
    name               = "privatelink.1.azurestaticapps.net"
    resource_group_key = "webapp_simple"
    vnet_links = {
      vnlk1 = {
        name     = "vnet-link"
        #lz_key   = "networking_spoke" 
        vnet_key = "spoke"
        registration_enabled = "false"
      }
    }
  }
}