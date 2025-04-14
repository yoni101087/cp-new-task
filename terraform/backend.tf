terraform {
  backend "s3" {
    bucket  = "jona-cp1"
    key     = "terraform/state.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}
