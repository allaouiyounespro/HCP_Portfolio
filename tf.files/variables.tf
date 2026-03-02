variable "aws_region" {
  description = "principal AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "domain_name" {
  description = "princpal domain"
  type        = string
  default     = "younesallaoui.com"
}

variable "alert_email" {
  description = "Cloudwatch's alarm email"
  type        = string

}
