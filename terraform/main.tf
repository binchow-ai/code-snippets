# Make sure to place your public and private keys, you can remove the comments
provider "mongodbatlas" {
  public_key = "sblvhoqe" 
  private_key  = "4b68d291-e87a-40a9-a199-450f3c98f728" 
}
resource "mongodbatlas_cluster" "test2" {
  project_id   = "642cbd00622e9a25ab0364fe"
  name         = "cluster-test"
  provider_instance_size_name = "M0"
  provider_name               = "TENANT"
  provider_region_name     = "US_EAST_1"
  backing_provider_name       = "AWS"
}

resource "mongodbatlas_project_ip_access_list" "test" {
    project_id = "642cbd00622e9a25ab0364fe"

    ip_address = "1.2.3.4"
    comment    = "cidr block for tf acc testing"

 }
output "standard_srv" {
    value = mongodbatlas_cluster.test2.connection_strings[0].standard_srv
}
