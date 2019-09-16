data "oci_identity_availability_domains" "test_ad" {
  compartment_id="${var.tenancy_ocid}"
}

output "ads_list" {
  value = "${data.oci_identity_availability_domains.test_ad.availability_domains.*.name}"
}
