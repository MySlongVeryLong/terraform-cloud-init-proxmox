output "private_ipv4" {

  description = "VM private IP"
  value       = flatten(proxmox_virtual_environment_vm.vm.ipv4_addresses[1])

}


output "mac_address" {
  description = "Container MAC Address"
  value       = proxmox_virtual_environment_container.lxc.network_interface.*.mac_address[0]
}

