### GLOBAL ###
variable "VIRTUAL_MACHINE_GLOBAL_USERNAME" {
  type = string
  default = null
}

variable "VIRTUAL_MACHINE_GLOBAL_GATEWAY" {
  type = string
  default = null
}

variable "VIRTUAL_MACHINE_GLOBAL_DATASTORE_ID_DISK" {
  type = string
  default = null
}

variable "VIRTUAL_MACHINE_GLOBAL_DATASTORE_ID_ISO" {
  type = string
  default = null
}

variable "VIRTUAL_MACHINE_GLOBAL_DATASTORE_ID_SNIPPET" {
  type = string
  default = null
}

### TRUENAS ###
variable "VIRTUAL_MACHINE_TRUEVIRTUAL_MACHINE_TRUENAS_NFS_MEDIA" {
  type = string
  default = null
}

variable "VIRTUAL_MACHINE_TRUENAS_IP_ADDRESS" {
  type = string
  default = null
}

### DOCKER ###
variable "VIRTUAL_MACHINE_DOCKER_IP_ADDRESS" {
  type = string
  default = null
}

variable "VIRTUAL_MACHINE_DOCKER_MAC_ADDRESS" {
  type = number
  default = null
}

variable "VIRTUAL_MACHINE_DOCKER_VMID" {
  type = number
  default = null
}

variable "VIRTUAL_MACHINE_DOCKER_CPU_CORES" {
  type = number
  default = null
}

variable "VIRTUAL_MACHINE_DOCKER_MEMORY_DEDICATED" {
  type = number
  default = null
}

variable "VIRTUAL_MACHINE_DOCKER_DISK_SIZE" {
  type = number
  default = null
}

### DEVELOPMENT ###
variable "VIRTUAL_MACHINE_DEVELOPMENT_IP_ADDRESS" {
  type = string
  default = null
}

variable "VIRTUAL_MACHINE_DEVELOPMENT_MAC_ADDRESS" {
  type = number
  default = null
}

variable "VIRTUAL_MACHINE_DEVELOPMENT_VMID" {
  type = number
  default = null
}

variable "VIRTUAL_MACHINE_DEVELOPMENT_CPU_CORES" {
  type = number
  default = null
}

variable "VIRTUAL_MACHINE_DEVELOPMENT_MEMORY_DEDICATED" {
  type = number
  default = null
}

variable "VIRTUAL_MACHINE_DEVELOPMENT_DISK_SIZE" {
  type = number
  default = null
}