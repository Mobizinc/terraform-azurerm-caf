global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}
resource_groups = {
  funapp = {
    name   = "funapp-private-vk"
    region = "region1"
  }

}
# app_service_plans = {
#   asp2 = {
#     resource_group_key = "funapp"
#     name               = "test-asp-vk"
#     reserved           = "false"
#     kind               = "Windows"
#     sku = {
#       tier = "PremiumV2"
#       size = "P3v2"
#     }
#   }
# }
# app_services = {
#   webapp1 = {
#     resource_group_key   = "funapp"
#     name                 = "iqwebapp-simplevk"
#     app_service_plan_key = "asp2"
#     https_only           = "true"
#     # vnet_integration = {
#     #   vnet_key   = "spoke"
#     #   subnet_key = "app1"
#     #   #lz_key     = "launchpad-ops-prod-re2-networking_spoke"
#     # }


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
#     #           resource_group_key = "funapp"
#     #           #lz_key             = "launchpad-ops-prod-re2-networking_spoke"
#     #           private_service_connection = {
#     #             name                 = "iqwebapp-simple-psc"
#     #             is_manual_connection = false
#     #             subresource_names    = ["sites"]
#     #           }
#     #           private_dns = {
#     #             zone_group_name = "default"
#     #             lz_key          = "privatedns"   # If the DNS keys are deployed in a remote landingzone
#     #             keys = ["azurewebsites"]
#     #           }
#     #     }
#     #   }
#   }
# }

# static_webapps = {
#   example_1 = {
#     resource_group_key   = "funapp"
#     name                 = "static-webapps-vk"
#   #  sku_tier             = "Standard" 
#     sku_size             = "Standard" 
#     github_private = "yes"
#     github_source = "https://github.com/onlyillusion/actions.git"
#     github_branch = "main"
#     github_token  = "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"
#     #     private_endpoints = {
#     # # Require enforce_private_link_endpoint_network_policies set to true on the subnet
#     #         f1 = {
#     #           name               = "static-webapps-vk-pe"
#     #           vnet_key           = "spoke"
#     #           subnet_key         = "app"
#     #           resource_group_key = "funapp"
#     #           #lz_key             = "launchpad-ops-prod-re2-networking_spoke"
#     #           private_service_connection = {
#     #             name                 = "static-webapps-vk-psc"
#     #             is_manual_connection = false
#     #             subresource_names    = ["staticSites"]
#     #           }
#     #           private_dns = {
#     #             zone_group_name = "default"
#     #             lz_key          = "privatedns"   # If the DNS keys are deployed in a remote landingzone
#     #             keys = ["web_dns"]
#     #           }
#     #     }
#     #   }
#   }
# }
# api_management = {
#   example_apim = {
#     name                 = "apim-vk"
#     resource_group_key   = "funapp"
#     publisher_name       = "My Company"
#     publisher_email      = "company@terraform.io"
#     sku_name             = "Developer_1"
#  #   public_network_access_enabled = "false"
#     # virtual_network_type = "Internal"
#     # virtual_network_configuration = {
#     #   vnet_key   = "spoke"
#     #   subnet_key = "app"
#     # }
#     private_endpoints = {
#       # Require enforce_private_link_endpoint_network_policies set to true on the subnet
#       f1 = {
#         name               = "api_management-test-pe"
#         vnet_key           = "spoke"
#         subnet_key         = "app"
#         resource_group_key = "funapp"
#         #lz_key             = "networking_spoke"
#         private_service_connection = {
#           name                 = "api_management-test-pe"
#           is_manual_connection = false
#           subresource_names    = ["Gateway"]
#         }
#         private_dns = {
#           zone_group_name = "default"
#           #lz_key          = "privatedns"   # If the DNS keys are deployed in a remote landingzone
#           keys = ["data_dns"]
#         }
#   }
# }
#   }
# }
#  private_dns = {
#   data_dns = {
#     name               = "privatelink.azure-api.net"
#     resource_group_key = "funapp"
#     vnet_links = {
#       vnlk1 = {
#         name     = "vnet-link"
#         #lz_key   = "networking_spoke" 
#         vnet_key = "spoke"
#         registration_enabled = "false"
#       }
#     }
#   }
#     web_dns = {
#     name               = "privatelink.1.azurestaticapps.net"
#     resource_group_key = "funapp"
#     vnet_links = {
#       vnlk1 = {
#         name     = "vnet-link"
#         #lz_key   = "networking_spoke" 
#         vnet_key = "spoke"
#         registration_enabled = "false"
#       }
#     }
#   }
# }



# vnets = {
#   spoke = {
#     resource_group_key = "funapp"
#     region             = "region2"
#     vnet = {
#       name          = "spoke"
#       address_space = ["10.1.0.0/24"]
#     }
#     specialsubnets = {}
#     subnets = {
#       app = {
#         name = "app"
#         cidr = ["10.1.0.0/25"]
#         enforce_private_link_endpoint_network_policies = true
#       }
#       app1 = {
#         name = "scope"
#         cidr = ["10.1.0.128/26"]
#         delegation = {
#           name               = "serverFarms"
#           service_delegation = "Microsoft.Web/serverFarms"
#           actions = [
#             "Microsoft.Network/virtualNetworks/subnets/action"
#           ]
#         }
#       }

#     }

#   }

# }




