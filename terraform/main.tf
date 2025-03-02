# Make sure to place your public and private keys, you can remove the comments
provider "mongodbatlas" {
  public_key = var.public_key 
  private_key  = var.private_key
}

#create a new project
data "mongodbatlas_roles_org_id" "demo" {
}

resource "mongodbatlas_project" "devax" {
  name   = "devax-day-for-gaming"
  org_id = data.mongodbatlas_roles_org_id.demo.org_id
}

#create a new cluster
resource "mongodbatlas_cluster" "demo" {
  project_id                  = mongodbatlas_project.devax.id
  name                        = "cluster-devax"
  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = "US_EAST_1"
  provider_instance_size_name = "M0"
}

#create db user and assign role
resource "mongodbatlas_database_user" "demo" {
  username           = "admin"
  password           = "Abc123"
  project_id         = mongodbatlas_project.devax.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = "devax"
  }
  roles {
    role_name     = "readWrite"
    database_name = "admin"
  }
  scopes {
    name = mongodbatlas_cluster.demo.name
    type = "CLUSTER"
  }

}

#ip write list
resource "mongodbatlas_project_ip_access_list" "test" {
  project_id = mongodbatlas_project.devax.id
  cidr_block = "0.0.0.0/0"
  comment    = "allows all"
}