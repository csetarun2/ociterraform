resource "oci_identity_group" "test_group" {
  compartment_id="${var.tenancy_ocid}"
  description="${var.group_description}"
  name="${var.group_name}"
}