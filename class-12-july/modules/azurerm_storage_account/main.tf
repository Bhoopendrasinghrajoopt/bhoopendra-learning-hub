resource "azurerm_resource_group" "practice" {
  for_each = var.storage
  name     = each.value.rg_name
  location = each.value.location

}
resource "azurerm_storage_account" "aru_storage" {

  for_each                 = var.storage
  name                     = each.value.stname
  location                 = each.value.location
  resource_group_name      = azurerm_resource_group.practice[each.key].name
  account_tier             = each.value.accounttier
  account_replication_type = each.value.accountreplication


}
variable "storage" {

}