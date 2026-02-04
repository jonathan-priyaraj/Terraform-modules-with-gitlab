
Purpose: Deploy and manage production infrastructure with this Terraform repo (modules + envs) using GitLab CI.

Prerequisites
AWS account and credentials configured (env vars or ~/.aws/credentials) 🚩
Terraform v1.14.3 (repo uses TERRAFORM_VERSION 1.14.3)
S3 backend created (update bucket name if needed). Repo currently references terraform-bucket-jonathan.
GitLab project with CI variables for secure settings (see CI section)
Project layout (important files)
production — production Terraform root (uses ../modules/*)
development — development root
modules — reusable modules: network, nat, compute, elb, iam, sg
.gitlab-ci.yml — pipeline (stages: version-check, init, fmt/validate, plan, apply, destroy)
terraform.tfvars — env-specific values (e.g., aws_region)
Step-by-step deploy (local or CI)
Clone repo:

git clone <repo-url> && cd modules-gitlab ✅
Inspect and set variables:

Review terraform.tfvars and module inputs (e.g., main.tf)
Replace backend bucket name (if you control backend)
Initialize & validate (local, production):

cd production
terraform init
terraform fmt && terraform validate
Plan:

terraform plan -var-file="terraform.tfvars" -out=prod.plan
Apply:

terraform apply "prod.plan"
OR let GitLab CI run apply (see CI steps below)
Destroy (if needed):

terraform destroy -var-file="terraform.tfvars" --auto-approve
Or set pipeline variable TERRAFORM_DESTROY=YES to run destroy job.
