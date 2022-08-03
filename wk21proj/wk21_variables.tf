variable "region" {
  description = "region to use for AWS resources"
  type        = string
  default     = "us-east-2"
}

variable "apple_cidr" {
  description = "CIDR range for created VPC"
  type        = string
  default     = "10.0.0.0/16"
}