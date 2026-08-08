module "resource_group_name" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.virtual_rgs
}

module "virtual_network" {
  depends_on = [module.resource_group_name]
  source     = "../../modules/azurerm_virtual_network"
  vnet       = var.virtual_network

}

module "subnet" {
  depends_on = [module.resource_group_name, module.virtual_network]
  source     = "../../modules/azurerm_subnet"
  subnet     = var.virtual_subnet

}

module "azurerm_public_ip" {
  depends_on = [module.resource_group_name]
  source     = "../../modules/azurerm_public_ip"
  pip        = var.virtual_pip
}

module "azurerm_network_security_group" {
  depends_on = [module.resource_group_name, module.subnet, ]
  source     = "../../modules/azurerm_network_security_group"
  nsg        = var.nsg

}

module "azurerm_virtual_machine" {
  depends_on = [module.resource_group_name, module.virtual_network, module.subnet, module.azurerm_public_ip]
  source     = "../../modules/azurerm_virtual_machine"
  hotstar_VM = var.virtual_vm
}

module "azurerm_storage_account" {
  depends_on = [ module.resource_group_name ]
  source = "../../modules/azurerm_storage_account"
  storage = var.storage
  
}