terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
  backend "s3" {
    bucket = "tek-terraform-bk"
    key    = "test.tfstate"
    region = "ap-southeast-1"
    access_key = "AKIAS7WSJ6HNOSXO6QGA"
    secret_key = "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"
  }
}
provider "docker" {}
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}
resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
