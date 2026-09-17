# define the proxmox n  
resource "proxmox_virtual_environment_vm" "vm" {

  node_name   = var.target_node
  vm_id       = 9001
  name        = "deploy-vm"
  description = "Managed by Terraform"
  tags        = ["terraform", "ubuntu"]

  # define the template we are going to clone

  clone {

    vm_id = 9000
    full  = true

  }


  cpu {

    cores = 2

  }


  memory {

    dedicated = 4096

  }

  disk {

    interface    = "scsi0"
    datastore_id = "local"
    size         = 32
    file_format  = "qcow2"


  }


  initialization {

    datastore_id = "local"

    user_account {

      username = var.vm_user
      password = var.vm_password
      keys     = [trimspace(data.local_file.ssh_public_key.content)]

    }

    ip_config {

      ipv4 {

        address = "dhcp"

        # address = "192.168.0.150/24"
        # gateway = 192.168.0.1"

      }

    }

  }

}


data "local_file" "ssh_public_key" {

  filename = "./id_ed25519.pub"

}

