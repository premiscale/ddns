variable "domain" {
  type = string
}

variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}

variable "aws_region" {
  type      = string
  sensitive = true
}

variable "domain_record" {
  type = string
}

variable "ip" {
  type = string
}