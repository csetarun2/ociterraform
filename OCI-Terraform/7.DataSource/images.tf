data "oci_core_images" "test_images" {
  compartment_id="${var.tenancy_ocid}"
}

#output "core_image_list" {
#  value = "${data.oci_core_images.test_images.images.*.id}"
#}

