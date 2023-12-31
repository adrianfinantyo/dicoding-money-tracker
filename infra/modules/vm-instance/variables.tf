variable "project_id" {
    type = string
}

variable "region" {
    type = string
}

variable "zone" {
    type = string
}

variable "machine_type" {
  type = string
  default = "f1-micro"
}