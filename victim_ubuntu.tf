#Local Variables
locals {
  vulnvm-name = "VulnServer"
}

# Create Security Group to access web
resource "azurerm_network_security_group" "victim-linux-nsg" {
  depends_on=[azurerm_resource_group.victim-network-rg]
  name = "vuln-web-linux-vm-nsg"
  location            = azurerm_resource_group.victim-network-rg.location
  resource_group_name = azurerm_resource_group.victim-network-rg.name
  security_rule {
    name                       = "allow-ssh"
    description                = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow-http"
    description                = "allow-http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  tags = {
    environment = var.environment
  }
}

#Public IP Address
resource "azurerm_public_ip" "vulnpublicip" {
    name                         = "ubuntupublic"
    location                     = azurerm_resource_group.victim-network-rg.location
    resource_group_name          = azurerm_resource_group.victim-network-rg.name
    allocation_method = "Dynamic"
}


#Create Network Interface
resource "azurerm_network_interface" "vuln-ubuntu" {
  name                = "victim-nic"
  location            = azurerm_resource_group.victim-network-rg.location
  resource_group_name = azurerm_resource_group.victim-network-rg.name

  ip_configuration {
    name                          = "${local.vulnvm-name}-ip"
    subnet_id                     = azurerm_subnet.victim-network-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.1.0.10"
    primary = true
        public_ip_address_id = azurerm_public_ip.vulnpublicip.id
  }
}




resource "azurerm_virtual_machine" "main" {
  name                  = "${local.vulnvm-name}"
  location              = azurerm_resource_group.victim-network-rg.location
  resource_group_name   = azurerm_resource_group.victim-network-rg.name
  network_interface_ids = [azurerm_network_interface.vuln-ubuntu.id]
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${local.vulnvm-name}-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "VulnServer"
    admin_username = "mike"
    admin_password = "Vpn123vpn123!"
    custom_data = file("vuln_bootstrap.sh") 
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = var.environment
  }
}