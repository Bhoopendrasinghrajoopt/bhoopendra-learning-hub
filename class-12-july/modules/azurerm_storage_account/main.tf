
resource "azurerm_storage_account" "aru_storage" {

  for_each                 = var.storage
  name                     = each.value.stname
  location                 = each.value.location
  resource_group_name      = each.value.rg_name
  account_tier             = each.value.accounttier
  account_replication_type = each.value.accountreplication


}
