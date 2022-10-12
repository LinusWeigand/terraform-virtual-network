resource "azurerm_virtual_machine" "vm" {
    name                 = "${var.prefix}-vm"
    location             = var.location
    resource_group_name  = "tstate"
    network_interface_ids = [azurerm_network_interface.nic.id]
    vm_size               = "Standard_DS1_v2"

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    storage_os_disk {
        name              = "${var.prefix}osdisk1"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    os_profile {
        computer_name  = "hostname"
        admin_username = "${var.prefix}admin"
        admin_password = "Password1234!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    tags = {
        environment = "Production"
    }
}