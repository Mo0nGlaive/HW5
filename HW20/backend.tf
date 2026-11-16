terraform {
  backend "s3" {
    bucket       = "terraform-state-mo0nglaive"
    key          = "aws-terraform-module/terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}