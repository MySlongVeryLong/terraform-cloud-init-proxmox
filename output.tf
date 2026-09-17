output "private_ipv4" {

  description = "VM private IP"
  value       = flatten(proxmox_virtual_environment_vm.vm.ipv4_addresses[1])

}


