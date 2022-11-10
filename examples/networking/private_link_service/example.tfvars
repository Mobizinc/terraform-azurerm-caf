private_link_service = {
  pls1 = {
    name = "pls1"
    resource_group_key = "rg1"
    load_balancer_frontend_ip_configuration = {
      lz_key = ""
      lb_key = ""
    }
    auto_approval_subscription_ids = ["00000000-0000-0000-0000-000000000000"]
    visibility_subscription_ids    = ["00000000-0000-0000-0000-000000000000"]
    enable_proxy_protocol = "false"
    fqdns = [""]
    nat_ip_configuration = {
      nat1 = {
        name = "nat_ip_configuration1"
        lz_key = ""
        vnet_key = ""
        subnet_key = ""
        primary = false
        private_ip_address         = "10.5.1.17"
        private_ip_address_version = "IPv4"
      }
      nat2 = {
        name = "nat_ip_configuration2"
        lz_key = ""
        vnet_key = ""
        subnet_key = ""
        primary = false
        private_ip_address         = "10.5.1.18"
        private_ip_address_version = "IPv4"
      }
    }
  }
}