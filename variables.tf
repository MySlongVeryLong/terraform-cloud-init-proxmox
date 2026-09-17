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
