global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name = "vmss-lb-exmp-rg"
  }
}

log_analytics = {
  law1 = {
    name               = "securitycenterworkspaceexample"
    resource_group_key = "rg1"
  }
}

security_center_workspace = {
  workspace = "law1"
  scopes = {
    subscription = {
      key    = ""
      lz_key = "" # optional
      id     = "/subscriptions/7b822bcb-9762-46f6-8877-d5b0212572ce"
    }
  }
}