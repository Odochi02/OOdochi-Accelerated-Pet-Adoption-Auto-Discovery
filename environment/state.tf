terraform {

  backend "s3" {

    bucket         = "OAPAAD-backend"
    key            = "OAPAAD/stage/compute/terraform.tfstate"
    region         = "eu-west-2"
    profile        = "Odochi"
    dynamodb_table = "OAPAAD_dynamo_table"

  }

}