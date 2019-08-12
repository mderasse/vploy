#===============================================================================
# vSphere Provider Variables
#===============================================================================
variable "vsphere-address" {
  type        = "string"
  description = "vSphere server URL"
}

variable "vsphere-username" {
  type        = "string"
  description = "vSphere server username"
}

variable "vsphere-password" {
  type        = "string"
  description = "vSphere server password"
}

variable "vsphere-allow_unverified_ssl" {
  type        = bool
  description = "Define if invalid SSL vSphere certificat should be authorized"
  default     = false
}

variable "vsphere-datacenter" {
  type        = "string"
  description = "vSphere Datacenter name"
}

variable "vsphere-cluster" {
  type        = "string"
  description = "vSphere Cluster Name"
}

variable "vsphere-network-dvs" {
  type        = "string"
  description = "vSphere DVS name"
}

variable "vsphere-datastore-iso" {
  type        = "string"
  description = "vSphere Datastore for Iso"
}

variable "infra-names" {
  type        = "string"
  description = "Names of infrastructures to configure on the vSphere"
}

variable "infra-vlans" {
  type        = "string"
  description = "Vlans of infrastructures to configure on the vSphere"
}

variable "list-isos" {
  type        = "string"
  description = "List of isos to upload on the vSphere"
}