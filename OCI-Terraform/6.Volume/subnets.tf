resource "oci_core_subnet" "mypub1" {
  cidr_block        = "10.0.1.0/24"
  compartment_id    = "${var.compartment_id}"
  vcn_id            = "${oci_core_vcn.test_vcn.id}"
  route_table_id    = "${oci_core_route_table.test_rt.id}"
  security_list_ids = ["${oci_core_security_list.test_security_list.id}"]
  display_name      = "mypub1"
}

resource "oci_core_subnet" "mypriv1" {
  cidr_block                 = "10.0.2.0/24"
  compartment_id             = "${var.compartment_id}"
  vcn_id                     = "${oci_core_vcn.test_vcn.id}"
  route_table_id             = "${oci_core_route_table.test_rt.id}"
  security_list_ids          = ["${oci_core_security_list.test_security_list.id}"]
  prohibit_public_ip_on_vnic = true
  display_name               = "mypriv1"
}
