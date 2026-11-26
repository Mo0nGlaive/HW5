terraform {
  backend "s3" {
    bucket       = "terraform-state-mo0nglaive"
    key          = "step-project3/terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}