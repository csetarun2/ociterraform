output "oci_core_vcn" {
  value = "${oci_core_vcn.test_vcn.id}"
}

output "url" {
  value = "http://${oci_core_instance.test_instance.public_ip}"
}
