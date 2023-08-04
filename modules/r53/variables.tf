variable "domain_name" {
  type        = string
  default     = ""
  description = "Domain name / Hosted Zone"
}
variable "sub_domain_name" {
  type        = string
  default     = ""
  description = "Sub-Domain name"
}
variable "resource_dns_name" {
  type = string
}
variable "resource_zone_id" {
  type = string
}