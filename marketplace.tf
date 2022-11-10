module "marketplace_agreement" {
  for_each = var.marketplace_agreements
  source              = "./modules/marketplace/agreement"
  settings            = each.value
}