# S3 bucket for storing build artifact
resource "aws_s3_bucket" "codeBuildBucket" {
  bucket = var.artifactBucket

  force_destroy = true

}

resource "aws_s3_bucket_acl" "cbBucketACL" {
  bucket = aws_s3_bucket.codeBuildBucket.id
  acl    = "private"
}



# Service role for CodeBuild
resource "aws_iam_role" "cbRole" {
  name = "codeBuildServiceRole"

  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
            }
        ]
    }
    EOF
}

# CloudWatch Group for CodeBuild Logs
resource "aws_cloudwatch_log_group" "cloudWatchGroup" {

  name              = var.codeBuildLogGroupvar
  retention_in_days = 0

}

# IAM Policy for CodeBuild Service Role
resource "aws_iam_role_policy" "cbPolicy" {

  role = aws_iam_role.cbRole.name
  name = "policyForCodeBuild"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "${aws_cloudwatch_log_group.cloudWatchGroup.arn}",
                "${aws_cloudwatch_log_group.cloudWatchGroup.arn}:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "${aws_s3_bucket.codeBuildBucket.arn}",
                "${aws_s3_bucket.codeBuildBucket.arn}/*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        }
    ]
}
POLICY

}

# CodeBuild Project Configuration
resource "aws_codebuild_project" "codeBuildProject" {
  name         = var.codeBuildProjectName
  service_role = aws_iam_role.cbRole.arn

  artifacts {
    type      = "S3"
    packaging = "NONE"
    location  = aws_s3_bucket.codeBuildBucket.bucket
  }

  source {
    buildspec = "buildspec_CodeBuild.yml"

    type            = "GITHUB"
    location        = var.repoURL
    git_clone_depth = 1
  }

  environment {

    type         = "LINUX_CONTAINER"
    image        = "aws/codebuild/standard:6.0"
    compute_type = "BUILD_GENERAL1_MEDIUM"


  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.cloudWatchGroup.name
    }
  }


}

# GitHub web hooks for CodeBuild
resource "aws_codebuild_webhook" "webHook" {

  project_name = aws_codebuild_project.codeBuildProject.name
  build_type   = "BUILD"
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PULL_REQUEST_CREATED,PULL_REQUEST_UPDATED,PULL_REQUEST_REOPENED"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "^refs/heads/dev$"
    }

    filter {
      type    = "BASE_REF"
      pattern = "^refs/heads/main$"

    }
  }

}


