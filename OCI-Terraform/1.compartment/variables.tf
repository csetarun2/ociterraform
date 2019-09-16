variable "tenancy_ocid" {
  type=string
}

variable "user_ocid" {
  type=string
}

variable "fingerprint" {
  type=string
}

variable "private_key_path" {
  type=string
}

variable "region" {
  type=string
}

variable "parent_compartment" {
  type=string
}

variable "compartment_description" {
  type=string
  default="This is tarun compartment"
}

variable "compartment_name" {
    type=string
}

