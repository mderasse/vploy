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

variable "vsphere-network-pg-public" {
  type        = "string"
  description = "vSphere Public Port Group"
}

variable "infra-name" {
  type        = "string"
  description = "Name of infrastructure"
}

variable "dns-domain" {
  type        = "string"
  description = "Network Domain name"
}

variable "dns-nameservers" {
  type        = "string"
  description = "List of DNS Server separate by a ,"
}

variable "network-public-gateway" {
  type        = "string"
  description = "Gateway IP"
}

variable "network-public-ip" {
  type        = "string"
  description = "Public IP"
}

variable "network-priv-range" {
  type        = "string"
  description = "Private Network CIDR"
}