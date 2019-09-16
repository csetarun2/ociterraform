provider "oci" {
  tenancy_ocid="${var.tenancy_ocid}"
  user_ocid="${var.user_ocid}"
  fingerprint="${var.fingerprint}"
  private_key_path="${var.private_key_path}"
  region="${var.region}"
}

resource "oci_identity_compartment" "tarun_compartment" {
  compartment_id="${var.parent_compartment}"
  description = "${var.compartment_description}"
  name="${var.compartment_name}"
}

