variable "project" {
  default = "my-demo-project-416806"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "instance_type" {
  default = "n1-standard-2"
}

variable "image_version" {
  default = "2.1-debian11"
}

variable "network_name" {
  default = "my-dataproc-vpc"
}

variable "subnet_name" {
  default = "my-dataproc-subnett"
}

variable "user" {
  default = "hungnp5"
}

variable "public_key" {
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDk5Fjq7AFBexAULFgxV1Dh6B6WNB0iigxt9fPjBo/vL hungnp5@vng.com.vn"
}

variable "staging_bucket" {
  default = "hung-dataproc-staging-bucket"
}
