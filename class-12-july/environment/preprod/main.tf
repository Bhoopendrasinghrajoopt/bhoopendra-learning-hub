module "resource_group_name" {
  source = "../../modules/azurerm_resource_group"
  rgs = {
    rgs1 = {
      name        = "rg-aru"
      rg-location = "central india"
      managed_by  = "bhoopendra"
    }
  }
}

module "virtual_network" {
  depends_on = [ module.resource_group_name ]
  source = "../../modules/azurerm_virtual_network"
  vnet = {
    vnet1 = {
      vnet_name     = "Hotstar-network"
      location      = "central india"
      rg_name       = "rg-aru"
      address_space = ["10.0.0.0/16"]
    }
  }

}

module "subnet" {
  depends_on = [ module.resource_group_name, module.virtual_network ]
  source = "../../modules/azurerm_subnet"
  subnet = {
    subnet1 = {
      subnet_name      = "frontend-subnet"
      rg_name          = "rg-aru"
      vnet_name        = "hotstar-network"
      address_prefixes = ["10.0.1.0/24"]
    }

    subnet2 = {
      subnet_name      = "backend-subnet"
      rg_name          = "rg-aru"
      vnet_name        = "hotstar-network"
      address_prefixes = ["10.0.2.0/24"]
    }
  }

}

module "azurerm_public_ip" {
  depends_on = [ module.resource_group_name ]
  source = "../../modules/azurerm_public_ip"
  pip = {
    pip1 = {
      pip_name          = "frontend-pip"
      rg_name           = "rg-aru"
      location          = "central india"
      allocation_method = "Static"
      sku               = "Standard"
    }

    pip2 = {
      pip_name          = "backend-pip"
      rg_name           = "rg-aru"
      location          = "central india"
      allocation_method = "Static"
      sku               = "Standard"
    }
  }
}

module "azurerm_virtual_machine" {
  depends_on = [ module.resource_group_name, module.virtual_network,module.subnet,module.azurerm_public_ip ]
  source = "../../modules/azurerm_virtual_machine"
  hotstar_VM = {
    vm1 = {
      vm_name        = "frondend-vm"
      admin_username = "frontednvm"
      admin_password = "Frontend@1234"
      vm_size        = "Standard_B2s"

      nic_name = "frontend-nic"
      location = "central india"
      rg_name  = "rg-aru"

      subnet_name = "frontend-subnet"
      vnet_name   = "hotstar-network"
      pip_name    = "frontend-pip"
    }

    vm2 = {
      vm_name        = "backend-vm"
      admin_username = "backendvm"
      admin_password = "Backend@1234"
      vm_size        = "Standard_B2s"

      nic_name = "backend-nic"
      location = "central india"
      rg_name  = "rg-aru"

      subnet_name = "backend-subnet"
      vnet_name   = "hotstar-network"
      pip_name    = "backend-pip"
    }
  }

}