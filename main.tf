### ssh key

data "local_file" "ssh_public_key" {
  filename = "./id_ed25519.pub"
}

### VM

resource "proxmox_virtual_environment_vm" "vm" {

  node_name   = var.target_node
  vm_id       = 9001
  name        = "deploy-vm"
  description = var.description
  tags        = var.vm_tags

  # Clone the Proxmox template
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

  # Disk
  disk {
    interface    = "scsi0"
    datastore_id = var.datastore
    size         = 32
    file_format  = "qcow2"
  }

  # Cloud-init initialization
  initialization {

    datastore_id = var.datastore

    user_account {
      username = var.vm_user
      password = var.vm_password
      keys     = [trimspace(data.local_file.ssh_public_key.content)]
    }

    ip_config {
      ipv4 {
        address = "dhcp"

        # address = "192.168.0.150/24"
        # gateway = 192.168.0.1
      }
    }
  }
}

### LXC
resource "proxmox_virtual_environment_container" "lxc" {
  node_name    = var.target_node
  vm_id        = 100
  description  = var.description
  tags         = var.lxc_tags
  unprivileged = var.unprivileged

  operating_system {
    template_file_id = var.os_template
    type             = var.os_type
  }

  initialization {
    hostname = var.lxc_name

    ip_config {
      ipv4 {

        address = "192.168.0.160/24"
        gateway = var.gateway
      }
    }

    user_account {

      keys     = [trimspace(data.local_file.ssh_public_key.content)]
      password = var.lxc_password
    }
  }

  network_interface {
    name    = var.vnic_name
    bridge  = var.vnic_bridge
    vlan_id = var.vlan_tag
  }

  cpu {
    cores = var.lxc_vcpu
  }

  memory {
    dedicated = var.lxc_memory
    swap      = var.lxc_memory_swap
  }

  disk {
    datastore_id = var.disk_storage
    size         = var.lxc_disk_size
  }


  started       = var.start_on_create
  start_on_boot = var.start_on_boot
  dynamic "startup" {
    for_each = (var.start_on_boot == true ? [1] : [])
    content {
      order      = var.start_order
      up_delay   = var.start_delay
      down_delay = var.shutdown_delay
    }
  }
}
