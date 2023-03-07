
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  automation = {
    name = "automation"
  }
}

automations = {
  auto1 = {
    name               = "automation"
    sku                = "basic"
    resource_group_key = "automation"
  }
}

automation_runbooks = {
  runbook1 = {
    name                   = "Get-AzureVMTutorial"
    resource_group_key     = "automation"
    automation_account_key = "auto1"
    log_verbose            = "true"
    log_progress           = "true"
    description            = "This is an example runbook"
    runbook_type           = "PowerShellWorkflow"
    publish_content_link = {
      uri = "https://raw.githubusercontent.com/azureautomation/Restart-Azure-VM-On-Alert/main/RestartAzureVmInResponseToVmAlertGlobalRunbook.ps1"
    }
  }
}

automation_webhooks = {
  webhook1 = {
    name                   = "restart"
    resource_group_key     = "automation"
    automation_account_key = "auto1"
    expiry_time            = "2028-01-01T00:00:00.000+00:00"
    automation_runbook_key = "runbook1"
  }
}

monitor_action_groups = {
  example = {
    action_group_name  = "example-ag-name"
    resource_group_key = "automation"
    shortname          = "example"

    automation_runbook_receiver  = {
      alert1 = {
        name                   = "alert_restart_caf"
        automation_account_key = "auto1"
        automation_runbook_key = "runbook1"
        automation_webhook_key = "webhook1"
        is_global_runbook      = true
      } #remove the following block if additional email alerts aren't needed.
    }
  }
}
