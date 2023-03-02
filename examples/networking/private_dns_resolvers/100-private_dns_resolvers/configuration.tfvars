global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}


resource_groups = {
  private_dns_region1 = {
    name   = "private-dns-rg"
    region = "region1"
  }
}

vnets = {
  vnet_test = {
    resource_group_key = "private_dns_region1"
    vnet = {
      name          = "test-vnet"
      address_space = ["10.10.100.0/24"]
    }
    specialsubnets = {

    }
    subnets = {
      # inbound = {
      #   name                                           = "inbound-dns"
      #   cidr                                           = ["10.10.100.0/25"]
      #   enforce_private_link_endpoint_network_policies = true
      #   enforce_private_link_service_network_policies  = false
      #   # delegation = {
      #   #   name               = "Microsoft.Network.dnsResolvers"
      #   #   service_delegation = "Microsoft.Network/dnsResolvers"
      #   #   actions = [
      #   #     "Microsoft.Network/virtualNetworks/subnets/join/action",
      #   #   ]
      #   # }
      # }
      # outbound = {
      #   name                                           = "outbound-dns"
      #   cidr                                           = ["10.10.100.128/25"]
      #   enforce_private_link_endpoint_network_policies = true
      #   # delegation = {
      #   #   name               = "Microsoft.Network.dnsResolvers"
      #   #   service_delegation = "Microsoft.Network/dnsResolvers"
      #   #   actions = [
      #   #     "Microsoft.Network/virtualNetworks/subnets/join/action",
      #   #   ]
      #   # }
      # }
    }
  }
  vnet_test2 = {
    resource_group_key = "private_dns_region1"
    vnet = {
      name          = "test-vnet2"
      address_space = ["10.20.100.0/24"]
    }
    specialsubnets = {

    }
    subnets = {
      # inbound = {
      #   name                                           = "inbound-dns"
      #   cidr                                           = ["10.10.100.0/25"]
      #   enforce_private_link_endpoint_network_policies = true
      #   enforce_private_link_service_network_policies  = false
      #   # delegation = {
      #   #   name               = "Microsoft.Network.dnsResolvers"
      #   #   service_delegation = "Microsoft.Network/dnsResolvers"
      #   #   actions = [
      #   #     "Microsoft.Network/virtualNetworks/subnets/join/action",
      #   #   ]
      #   # }
      # }
      # outbound = {
      #   name                                           = "outbound-dns"
      #   cidr                                           = ["10.10.100.128/25"]
      #   enforce_private_link_endpoint_network_policies = true
      #   # delegation = {
      #   #   name               = "Microsoft.Network.dnsResolvers"
      #   #   service_delegation = "Microsoft.Network/dnsResolvers"
      #   #   actions = [
      #   #     "Microsoft.Network/virtualNetworks/subnets/join/action",
      #   #   ]
      #   # }
      # }
    }
  }
}

private_dns_resolvers = {
  private_dns_resolver = {
     name               = "testresolver"
     resource_group_key = "private_dns_region1"
     vnet = {
      key = "vnet_test"
       # lz_key = ""
     }
        
    inbound_endpoint = {
      example_1 = {
        name = "inbound_endpoint"
        vnet_key = "vnet_test"
        subnet_key = "inbound"
        #subnet_id = "/subscriptions/xxx/resourceGroups/private-dns-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/inbound-dns"
    
      }
    }
    outbound_endpoint = {
      example_1 = {
        name = "outbound_endpoint"
        vnet_key = "vnet_test"
        subnet_key = "outbound"
        #subnet_id = "/subscriptions/xxx/resourceGroups/private-dns-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/outbound-dns"
      }
    }
  }
  private_dns_resolver2 = {
     name               = "testresolver2"
     resource_group_key = "private_dns_region1"
     vnet = {
      key = "vnet_test2"
       # lz_key = ""
     }
        
    inbound_endpoint = {
      example_1 = {
        name = "inbound_endpoint"
        vnet_key = "vnet_test"
        subnet_key = "inbound"
        #subnet_id = "/subscriptions/xxx/resourceGroups/private-dns-rg/providers/Microsoft.Network/virtualNetworks/test-vnet2/subnets/inbound-dns"
    
      }
    }
    outbound_endpoint = {
      example_1 = {
        name = "outbound_endpoint"
        vnet_key = "vnet_test"
        subnet_key = "outbound"
        #subnet_id = "/subscriptions/xxx/resourceGroups/private-dns-rg/providers/Microsoft.Network/virtualNetworks/test-vnet2/subnets/outbound-dns"
      }
    }
  }
}

private_dns_forwarding = {
  private_dns_forwarding_1 = {
     name               = "testresolver-forwarding"
     resource_group_key = "private_dns_region1"
     private_dns_resolvers = {
      outbound_endpoint_key = "example_1"
      key      = "private_dns_resolver"
      # lz_key = ""
    }
    rulesets = {
      rule_1 = {
        name = "rule1"
        domain_name = "google.com."
        ipdddress = "8.8.8.8"
        port = "53"
      }
    }
    virtualnetworklinks = {
      link_1 = {
        name = "link1"
        vnet_key = "vnet_test"
      }
    }
  }
  private_dns_forwarding_2 = {
     name               = "testresolver-forwarding2"
     resource_group_key = "private_dns_region1"
     private_dns_resolvers = {
      outbound_endpoint_key = "example_1"
      key      = "private_dns_resolver2"
      # lz_key = ""
    }
    rulesets = {
      rule_1 = {
        name = "rule1"
        domain_name = "google.com."
        ipdddress = "8.8.8.8"
        port = "53"
      }
    }
    virtualnetworklinks = {
      link_1 = {
        name = "link1"
        vnet_key = "vnet_test2"
      }
    }
  }
}