data "vsphere_datacenter" "datacenter" {
  name = "${var.vsphere-datacenter}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere-cluster}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_resource_pool" "resource-pool" {
  name          = "${var.infra-name}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "pg-priv" {
  name          = "${var.infra-name}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "pg-pub" {
  name          = "${var.vsphere-network-pg-public}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}