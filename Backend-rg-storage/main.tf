resource "azurerm_resource_group" "rg-backend" {
  for_each = var.rg
  name     = each.value.rg_name
  location = each.value.location
}
resource "azurerm_storage_account" "st-backend" {
  depends_on = [azurerm_resource_group.rg-backend]
  for_each   = var.st

  name                = each.value.st_name
  resource_group_name = each.value.rg_name
  location            = each.value.location

  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}

resource "azurerm_storage_container" "backend-container" {
  depends_on            = [azurerm_resource_group.rg-backend, azurerm_storage_account.st-backend]
  for_each              = var.st
  name                  = each.value.container_name
  storage_account_id    = data.azurerm_storage_account.st-backend[each.key].id
  container_access_type = each.value.access_type
}
data "azurerm_storage_account" "st-backend" {
    depends_on = [ azurerm_storage_account.st-backend ]

  for_each = var.st

  name                = each.value.st_name
  resource_group_name = each.value.rg_name
}