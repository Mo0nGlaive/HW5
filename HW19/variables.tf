variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "admin_ip" {
  type        = string
}

variable "public_key_path" {
  type        = string
}
