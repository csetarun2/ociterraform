resource "oci_core_vcn" "test_vcn" {
  cidr_block     = "${var.vcn_cidr_block}"
  compartment_id = "${var.compartment_id}"
  display_name   = "${var.vcn_display_name}"
  dns_label      = "${var.dns_label}"
}

resource "oci_core_internet_gateway" "test_internet_gateway" {
  compartment_id = "${var.compartment_id}"
  vcn_id         = "${oci_core_vcn.test_vcn.id}"
  display_name   = "${var.igw_name}"
  enabled        = true
}


