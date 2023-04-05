# Make sure to place your public and private keys, you can remove the comments
provider "mongodbatlas" {
  public_key = "sblvhoqe" 
  private_key  = "4b68d291-e87a-40a9-a199-450f3c98f728" 
}
resource "mongodbatlas_cluster" "test2" {
  project_id   = "ProjectID"
  name         = "cluster-test"
  num_shards   = 1

  replication_factor = 3
  backup_enabled               = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "4.0"

  //Provider Settings "block"
  provider_name               = "AWS"
  disk_size_gb                = 10
  provider_volume_type        = "STANDARD"
  provider_encrypt_ebs_volume = true
  provider_instance_size_name = "M0"
  provider_region_name        = "US-EAST-1"
}
resource "mongodbatlas_network_container" "test" {
    project_id       = "ProjectID"
    atlas_cidr_block = "10.8.0.0/21"
    provider_name    = "AWS"
  }
resource "mongodbatlas_project_ip_whitelist" "test" {
    project_id = "ProjectID"

    whitelist {
      cidr_block = "1.2.3.4"
      comment    = "cidr block for tf acc testing"
    }
    whitelist {
      ip_address = "2.3.4.5/32"
      comment    = "ip address for tf acc testing"
    }
    whitelist {
      cidr_block = "3.4.5.6/34"
      comment    = "cidr block for tf acc testing"
    }
    whitelist {
      ip_address = "4.5.6.7"
      comment    = "ip address for tf acc testing"
    }
 }

