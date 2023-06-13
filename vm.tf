resource "azurerm_linux_virtual_machine" "manager_vms" {
  count = var.manager_instance_count
  name                  = "${var.resource_group_name}_manager_vms-${count.index}"
  computer_name         ="manager-${count.index}"
  resource_group_name   = var.resource_group_name
  location              = var.resource_group_location
  size                  = var.manager_instance_size
  admin_username        = "ubuntu"
  network_interface_ids = [
    azurerm_network_interface.manager_nic[count.index].id,
  ]
  

  admin_ssh_key {
    username   = "ubuntu"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    name = "manager_osdisk-${count.index}"
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
    disk_size_gb = var.manager_disk_size
  }

  tags = {
    type = "manager"
  }
}

resource "azurerm_recovery_services_vault" "services_vault" {
  name                = "${var.resource_group_name}-services-vault"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}

resource "azurerm_backup_policy_vm" "manual_vm_backup" {
  name                = "manual_vm_backup_policy"
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.services_vault.name

  backup {
    frequency = "Daily"
    time      = "20:30"
  }
  retention_daily {
    count = 10
  }
}

resource "azurerm_linux_virtual_machine" "manual_vms" {
  count                 = var.manual_instance_count
  name                  = "${var.resource_group_name}_manual_vms-${count.index}"
  computer_name         ="manual-${count.index}"
  resource_group_name   = var.resource_group_name
  location              = var.resource_group_location
  size                  = var.manual_instance_size
  admin_username        = "ubuntu"
  network_interface_ids = [
    azurerm_network_interface.manual_nic[count.index].id,
  ]

  admin_ssh_key {
    username   = "ubuntu"
    public_key = file("~/.ssh/id_rsa.pub")
  }

   source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    name = "manual_osdisk-${count.index}"
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
    disk_size_gb         = var.manual_disk_size
  }

  tags = {
    type = "manual"
  }
}

resource "azurerm_backup_protected_vm" "manual_vm_backup" {
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.services_vault.name
  source_vm_id        = azurerm_linux_virtual_machine.manual_vms[0].id
  backup_policy_id    = azurerm_backup_policy_vm.manual_vm_backup.id
}

resource "azurerm_linux_virtual_machine" "worker_vms" {
  count                 = var.worker_instance_count
  name                  = "${var.resource_group_name}_worker_vms-${count.index}"
  computer_name         ="worker-${count.index}"
  resource_group_name   = var.resource_group_name
  location              = var.resource_group_location
  size                  = var.worker_instance_size
  admin_username        = "ubuntu"
  network_interface_ids = [
    azurerm_network_interface.worker_nic[count.index].id,
  ]

  admin_ssh_key {
    username   = "ubuntu"
    public_key = file("~/.ssh/id_rsa.pub")
  }

   source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    name = "worker_osdisk-${count.index}"
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
    disk_size_gb         = var.worker_disk_size
  }

  tags = {
    type = "worker"
  }
}

resource "azurerm_linux_virtual_machine" "worker_gpu_vms" {
  count                 = var.gpu_instance_count
  name                  = "${var.resource_group_name}_worker_gpu_vms-${count.index}"
  computer_name         ="worker-gpu-${count.index}"
  resource_group_name   = var.resource_group_name
  location              = var.resource_group_location
  size                  = var.gpu_instance_size
  admin_username        = "ubuntu"
  network_interface_ids = [
    azurerm_network_interface.worker_gpu_nic[count.index].id,
  ]

  admin_ssh_key {
    username   = "ubuntu"
    public_key = file("~/.ssh/id_rsa.pub")
  }

   source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    name = "worker_gpu_osdisk-${count.index}"
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
    disk_size_gb         = var.gpu_disk_size
  }

  tags = {
    type = "worker_gpu"
  }
}
