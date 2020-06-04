# victim company name 
variable "victim_company" {
  type        = string
  description = "MikeNet is a test victim company"
}

# azure region
variable "location" {
  type        = string
  description = "Azure region where the resources will be created"
  default     = "West US 2"
}

# attacker company name 
variable "attacker_company" {
  type        = string
  description = "EvilCorp is the APT group"
}

# environment
variable "environment" {
  type        = string
  description = "Staging or Production"
}

# vulnvm-name
variable "vulnvm-name" {
  type        = string
  description = "Name of Vulnerable VM"
}

# username
variable "username" {
  type        = string
  description = "Username"
}

# password
variable "password" {
  type        = string
  description = "Password"
}

