
# Load Vcenter Data
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

data "vsphere_network" "portgroup_private" {
  name          = "${var.infra-name}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "portgroup_public" {
  name          = "${var.vsphere-network-pg-public}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_virtual_machine" "template_ubuntu" {
  name          = "ubuntu"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

#===============================================================================
# Load Datastores
#===============================================================================
data "vsphere_datastore" "datastore_1" {
  name          = "datastore_1"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_datastore" "datastore_2" {
  name          = "datastore_2"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

#===============================================================================
# Gateway deployement
#===============================================================================
resource "vsphere_virtual_machine" "gateway" {
  name               = "gateway.${var.infra-name}"
  resource_pool_id   = "${data.vsphere_resource_pool.resource-pool.id}"
  datastore_id       = "${data.vsphere_datastore.datastore_1.id}"
  folder             = "/${var.vsphere-datacenter}/vm/${var.infra-name}"
  num_cpus           = 1
  memory             = 512
  memory_reservation = 512
  guest_id           = "ubuntu64Guest"

  disk {
    label = "disk0"
    size  = "30"
  }

  network_interface {
    network_id   = "${data.vsphere_network.portgroup_public.id}"
    adapter_type = "vmxnet3"
  }

  network_interface {
    network_id   = "${data.vsphere_network.portgroup_private.id}"
    adapter_type = "vmxnet3"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template_ubuntu.id}"

    customize {
      network_interface {
        ipv4_address = "${element(split("/", var.network-public-ip), 0)}"
        ipv4_netmask = "${element(split("/", var.network-public-ip), 1)}"
      }

      network_interface {
        ipv4_address = "${cidrhost(var.network-priv-range, 1)}"
        ipv4_netmask = "${element(split("/", var.network-priv-range), 1)}"
      }

      linux_options {
        host_name = "gateway"
        domain    = "${var.dns-domain}"
      }

      ipv4_gateway    = "${var.network-public-gateway}"
      dns_suffix_list = ["${var.dns-domain}"]
      dns_server_list = "${split(",", var.dns-nameservers)}"
    }
  }
}

#===============================================================================
# WebServer
# Create www (.X)
#===============================================================================
resource "vsphere_virtual_machine" "www" {
  count              = "${var.instance-www-count}"
  name               = "www${count.index + 1}.${var.infra-name}"
  resource_pool_id   = "${data.vsphere_resource_pool.resource-pool.id}"
  datastore_id       = "${data.vsphere_datastore.datastore_1.id}"
  folder             = "/${var.vsphere-datacenter}/vm/${var.infra-name}"
  num_cpus           = 2
  memory             = 2048
  memory_reservation = 2048
  guest_id           = "ubuntu64Guest"

  disk {
    label = "disk0"
    size  = "30"
  }

  network_interface {
    network_id   = "${data.vsphere_network.portgroup_private.id}"
    adapter_type = "vmxnet3"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template_ubuntu.id}"

    customize {
      network_interface {
        ipv4_address = "${cidrhost(var.network-priv-range, 2 + count.index)}"
        ipv4_netmask = "${element(split("/", var.network-priv-range), 1)}"
      }

      linux_options {
        host_name = "www${count.index + 1}"
        domain    = "${var.dns-domain}"
      }

      ipv4_gateway    = "${cidrhost(var.network-priv-range, 1)}"
      dns_suffix_list = ["${var.dns-domain}"]
      dns_server_list = "${split(",", var.dns-nameservers)}"
    }
  }
}

#===============================================================================
# mysql deployement
# Create mysqlX (.1X)
#===============================================================================
resource "vsphere_virtual_machine" "mysql" {
  count              = "${var.instance-mysql-count}"
  name               = "mysql${count.index + 1}.${var.infra-name}"
  resource_pool_id   = "${data.vsphere_resource_pool.resource-pool.id}"
  datastore_id       = "${data.vsphere_datastore.datastore_1.id}"
  folder             = "/${var.vsphere-datacenter}/vm/${var.infra-name}"
  num_cpus           = 2
  memory             = 6144
  memory_reservation = 6144
  guest_id           = "ubuntu64Guest"

  disk {
    label = "disk0"
    size  = "50"
  }

  network_interface {
    network_id   = "${data.vsphere_network.portgroup_private.id}"
    adapter_type = "vmxnet3"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template_ubuntu.id}"

    customize {
      network_interface {
        ipv4_address = "${cidrhost(var.network-priv-range, 10 + count.index)}"
        ipv4_netmask = "${element(split("/", var.network-priv-range), 1)}"
      }

      linux_options {
        host_name = "mysql${count.index + 1}"
        domain    = "${var.dns-domain}"
      }

      ipv4_gateway    = "${cidrhost(var.network-priv-range, 1)}"
      dns_suffix_list = ["${var.dns-domain}"]
      dns_server_list = "${split(",", var.dns-nameservers)}"
    }
  }
}
