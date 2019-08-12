data "vsphere_datacenter" "datacenter" {
  name = "${var.vsphere-datacenter}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere-cluster}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_distributed_virtual_switch" "dvs" {
  name          = "${var.vsphere-network-dvs}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

# Creating Template factory. It doesn't need vlans & co
resource "vsphere_folder" "templates_folder" {
  path          = "templates"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
resource "vsphere_resource_pool" "templates_resource-pool" {
  name                    = "templates"
  parent_resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
}

# Looping over given infras
# Creating Directory
resource "vsphere_folder" "folder" {
  count         = "${length(split(",", var.infra-names))}"
  path          = "${element(split(",", var.infra-names), count.index)}"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

# Creating Resource Pool
resource "vsphere_resource_pool" "resource-pool" {
  count                   = "${length(split(",", var.infra-names))}"
  name                    = "${element(split(",", var.infra-names), count.index)}"
  parent_resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
}

# Creating DVS PortGroup
resource "vsphere_distributed_port_group" "port-group" {
  count                           = "${length(split(",", var.infra-names))}"
  name                            = "${element(split(",", var.infra-names), count.index)}"
  distributed_virtual_switch_uuid = "${data.vsphere_distributed_virtual_switch.dvs.id}"

  vlan_id         = "${element(split(",", var.infra-vlans), count.index)}"
  number_of_ports = 100
  active_uplinks  = ["lag1"]

  allow_forged_transmits = true
  block_override_allowed = true
  failback               = false
  teaming_policy         = "loadbalance_ip"
}
# End of Loop over give infras


# Loop over isos to upload
resource "vsphere_file" "preseed_iso_upload" {
  count              = "${length(split(",", var.list-isos))}"
  datacenter         = "${data.vsphere_datacenter.datacenter.name}"
  datastore          = "${var.vsphere-datastore-iso}"
  source_file        = "../../generated/isos/${element(split(",", var.list-isos), count.index)}"
  destination_file   = "isos/${element(split(",", var.list-isos), count.index)}"
  create_directories = true # Look like there is an issue with that parameter...
}
# End of Loop over isos to upload