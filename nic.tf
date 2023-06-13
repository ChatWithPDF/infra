resource "azurerm_network_security_group" "manager_sg" {
  name                = "${var.resource_group_name}_manager_sg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowInboundHTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowInboundHTTPS"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "worker_sg" {
  name                = "${var.resource_group_name}_worker_sg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "manual_sg" {
  name                = "${var.resource_group_name}_manual_sg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface" "manual_nic" {
    count = var.manual_instance_count

    name    = "${var.resource_group_name}_manual_nic-${count.index}"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name       

    ip_configuration {
      name      = "manual_ipconfig-${count.index}"
      subnet_id = azurerm_subnet.subnet_internal.id
      private_ip_address_allocation = "Dynamic"  
    }
}

resource "azurerm_network_interface" "manager_nic" {
    count = var.manager_instance_count

    name    = "${var.resource_group_name}_manager_nic-${count.index}"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name      

    ip_configuration {
      name      = "manager_ipconfig-${count.index}"
      subnet_id = azurerm_subnet.subnet_internal.id
      private_ip_address_allocation = "Dynamic"  
      public_ip_address_id = "${count.index == 0 ? azurerm_public_ip.public_ip.id : null}"
    }
}

resource "azurerm_network_interface" "worker_nic" {
    count = var.worker_instance_count 

    name    = "${var.resource_group_name}_worker_nic-${count.index}"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name
            

    ip_configuration {
      name      = "worker_ipconfig-${count.index}"
      subnet_id = azurerm_subnet.subnet_internal.id
      private_ip_address_allocation = "Dynamic"  
    }
}

resource "azurerm_network_interface" "worker_gpu_nic" {
    count = var.gpu_instance_count

    name    = "${var.resource_group_name}_worker_gpu_nic-${count.index}"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name

    ip_configuration {
      name      = "worker_gpu_ipconfig-${count.index}"
      subnet_id = azurerm_subnet.subnet_internal.id
      private_ip_address_allocation = "Dynamic"  
    }
}

resource "azurerm_network_interface_security_group_association" "manager_nic_sg_association" {
  count = var.manager_instance_count

  network_interface_id      = azurerm_network_interface.manager_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.manager_sg.id
}

resource "azurerm_network_interface_security_group_association" "worker_nic_sg_association" {
  count = var.worker_instance_count

  network_interface_id      = azurerm_network_interface.worker_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.worker_sg.id
}

resource "azurerm_network_interface_security_group_association" "worker_gpu_nic_sg_association" {
  count = var.gpu_instance_count

  network_interface_id      = azurerm_network_interface.worker_gpu_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.worker_sg.id
}

resource "azurerm_network_interface_security_group_association" "manual_nic_sg_association" {
  count = var.manual_instance_count

  network_interface_id      = azurerm_network_interface.manual_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.manual_sg.id
}