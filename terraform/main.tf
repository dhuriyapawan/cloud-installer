terraform {
  
  required_providers {
    aws = {
              source = "hashicorp/aws"
              version = "~>5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

# IAM User

data "aws_iam_policy_document" "s3_policy" {
    statement {
      
      effect = "Allow"
      actions = [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject"
      ]

    resources = [ 
        aws_s3_bucket.my_bucket.arn,
        "${aws_s3_bucket.my_bucket.arn}/*"
        
     ]
    }  
}

resource "aws_iam_user_policy" "github_policy" {
    name = "github-s3-policy"
    user =aws_iam_user.github_user.name
    policy = data.aws_iam_policy_document.s3_policy.json

}

# Aceess Keysre
resource "aws_iam_access_key" "github_acces_key" {
    user = aws_iam_user_policy.github_user.name
  
}
