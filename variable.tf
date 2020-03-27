variable "vpc_id" {
    default = ""
}

variable "ami" {
    default = ""
    description = "ami used for BI server" 
}

variable "instance_count" {
  default = ""
}

variable "instance_type" {
  default = ""
  description = "instance type used for BI server" 
}

variable "key_name" {
  default     = ""
  description = "keypair used for BI server" 
}

variable "subnet_id" {
  default     = ""
  description = "subnet used to launch BI server" 
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "db_name" {
  default     = ""
}

variable "db_user" {
  default     = ""
}

variable "db_password" {
  default     = ""
}

variable "subnets" {
  type        = list(string)
  default     = []
  description = "List of subnets used for DB subnet group" 
}

variable "cidr_app_sg" {
  type        = list(string)
  default     = []
  description = "List of CIDR range allows RDP access of BI Gateway server"
}

variable "cluster_identifier" {
  type        = string
  default     = ""
  description = "Name of the cluster_identifier"
}

variable "engine" {
  type        = string
  default     = ""
  description = "Type of aurora serverless engine"
}

variable "engine_version" {
  type        = string
  default     = ""
  description = "Version of the serverless engine"
}

variable "engine_mode" {
  type        = string
  default     = ""
  description = "Engine mode of aurora"
}

variable "max_capacity" {
  type        = string
  default     = ""
  description = "Maximum compute unit of Aurora serverless"
}

variable "min_capacity" {
  type        = string
  default     = ""
  description = "Minimum compute unit of Aurora serverless"
}

