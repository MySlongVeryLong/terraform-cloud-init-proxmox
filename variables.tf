variable "pve_endpoint" {

  description = "Proxmox VE API endpoint"
  type        = string
  sensitive   = false

}

variable "pve_token_id" {

  description = "Proxmox token id"
  type        = string
  sensitive   = false

}

variable "pve_api_token" {

  description = "Proxmox API token in format user@realm!tokenid=secret"
  type        = string
  sensitive   = false

}

variable "target_node" {

  description = "Promox node name"
  type        = string
  default     = "pve-1"

}

variable "vm_user" {

  description = "VM username"
  type        = string
  sensitive   = false

}

variable "vm_password" {

  description = "VM user password"
  type        = string
  sensitive   = true

}

variable "datastore" {

  description = "VM disk to store on the node"
  type        = string
  default     = "local"

}

variable "description" {

  description = "Just a simple note"
  type        = string
  default     = null

}

variable "vm_tags" {

  description = "Proxmox tags for VM"
  type        = list(string)
  default     = null

}

# Container basic config

variable "lxc_name" {

  description = "lxc hostname"
  type        = string
  default     = null

}

variable "os_template" {

  description = "An OS template for LXC"
  type        = string

}

variable "os_type" {
  description = "Container OS specific setup, uses setup scripts in `/usr/share/lxc/config/<ostype>.common.conf`."
  type        = string
  default     = "unmanaged"
  validation {
    condition     = contains(["alpine", "archlinux", "centos", "debian", "devuan", "fedora", "gentoo", "kali", "nixos", "opensuse", "ubuntu", "unmanaged"], var.os_type)
    error_message = "Invalid OS type setting: ${var.os_type}."
  }
}

variable "lxc_password" {

  description = "password for container"
  type        = string
  sensitive   = true

}

variable "lxc_tags" {

  description = "Proxmox tags for LXC"
  type        = list(string)
  default     = null

}

variable "unprivileged" {

  description = "set container to unprivileged"
  type        = bool
  default     = true

}


### Container resources

variable "lxc_vcpu" {
  description = "Number of CPU cores."
  type        = number
  default     = 1
}

variable "lxc_memory" {
  description = "Memory size in `MiB`."
  type        = number
  default     = 512
}

variable "lxc_memory_swap" {
  description = "Memory swap size in `MiB`."
  type        = number
  default     = 512
}

### Startup variables

variable "start_on_boot" {
  description = "Start container on PVE boot."
  type        = bool
  default     = false
}

variable "start_order" {
  description = "Start order, e.g. `1`."
  type        = number
  default     = 1
}

variable "start_delay" {
  description = "Startup delay in seconds, e.g. `30`."
  type        = number
  default     = null
}

variable "shutdown_delay" {
  description = "Shutdown delay in seconds, e.g. `30`."
  type        = number
  default     = null
}

variable "start_on_create" {
  description = "Start container after creation."
  type        = bool
  default     = true
}

### Disk Variables

variable "disk_storage" {
  description = "Disk storage location."
  type        = string
  default     = "local"
}

variable "lxc_disk_size" {
  type    = number
  default = 8
}

### Network Variables
variable "vnic_name" {
  description = "Networking adapter name."
  type        = string
  default     = "eth0"
}

variable "vnic_bridge" {
  description = "Networking adapter bridge, e.g. `vmbr0`."
  type        = string
  default     = "vmbr0"
}

variable "vlan_tag" {
  description = "Networking adapter VLAN tag."
  type        = number
  default     = 0
}

variable "gateway" {

  description = "gateway IP for VMs and LXCS"
  type        = string
  default     = null

}


