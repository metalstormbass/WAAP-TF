#Variables for victim networks

variable "victim-network-vnet-cidr" {
  type        = string
  description = "The CIDR of the network VNET"
}
variable "victim-network-subnet-cidr" {
  type        = string
  description = "The CIDR for the network subnet"
}

#Variables for attacker networks

variable "attacker-network-vnet-cidr" {
  type        = string
  description = "The CIDR of the network VNET"
}
variable "attacker-network-subnet-cidr" {
  type        = string
  description = "The CIDR for the network subnet"
}
