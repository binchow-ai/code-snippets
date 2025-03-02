variable "vpc_name" {
  default = "game-demo"
}

variable "default_group_id" {
  default = "group1"
}

variable "player_table_name" {
  default = "PlayerTable"
}

variable "game_session_table_name" {
  default = "GameSessionTable"

}

variable "mongodb_user" {
  default = "demo"
}

variable "mongodb_pwd" {
  default = "Abcd1234"
}

variable "provider_region_name" {
  default = "US_EAST_1"
}

variable "public_key" {
  default = "bgcxmqss"
}

variable "private_key" {
  default = "7ef3f34a-b1db-4c82-978c-6803c5bc461b"
}
