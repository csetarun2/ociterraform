resource "oci_core_route_table" "test_rt" {
  compartment_id = "${var.compartment_id}"
  vcn_id         = "${oci_core_vcn.test_vcn.id}"
  display_name   = "${var.rtdname}"
  route_rules {
    network_entity_id = "${oci_core_internet_gateway.test_internet_gateway.id}"
    destination       = "0.0.0.0/0"
  }
}
