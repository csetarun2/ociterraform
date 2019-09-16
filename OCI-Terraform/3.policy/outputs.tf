output "policy_details" {
  value = "${oci_identity_policy.test_policy.id}"
}
output "policy_statements" {
  value = "${oci_identity_policy.test_policy.statements}"
}
