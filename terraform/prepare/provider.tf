#===============================================================================
# vSphere Provider
#===============================================================================
provider "vsphere" {
  user           = "${var.vsphere-username}"
  password       = "${var.vsphere-password}"
  vsphere_server = "${var.vsphere-address}"

  # if you have a self-signed cert
  allow_unverified_ssl = "${var.vsphere-allow_unverified_ssl}"
}
