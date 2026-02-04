## Terraform Production Deployment — Step-by-Step Guide

**Purpose**
Deploy and manage production infrastructure using this Terraform repository (modules + environments) with GitLab CI.

---

## Prerequisites

* AWS account with credentials configured:

  * Environment variables **or**
  * `~/.aws/credentials`
* Terraform **v1.14.3**
  (Repo uses `TERRAFORM_VERSION=1.14.3`)
* S3 backend bucket created

  * Default referenced: `terraform-bucket-jonathan`
  * Update if using your own bucket
* GitLab project configured with CI variables for secure settings

---

## Project Layout (Key Files)

```
production/     # Production Terraform root (uses ../modules/*)
development/    # Development Terraform root
modules/        # Reusable modules:
                #   - network
                #   - nat
                #   - compute
                #   - elb
                #   - iam
                #   - sg

.gitlab-ci.yml  # CI pipeline:
                # version-check → init → fmt/validate → plan → apply → destroy

terraform.tfvars # Environment-specific values (e.g., aws_region)
```

---

## Step-by-Step Deployment

### 1️⃣ Clone Repository

```bash
git clone <repo-url>
cd modules-gitlab
```

---

### 2️⃣ Review & Configure Variables

* Inspect:

  ```bash
  terraform.tfvars
  production/main.tf
  module inputs
  ```

* Update backend bucket if required:

  ```hcl
  bucket = "terraform-bucket-jonathan"
  ```

---

### 3️⃣ Initialize & Validate (Production)

```bash
cd production

terraform init
terraform fmt
terraform validate
```

---

### 4️⃣ Plan Deployment

```bash
terraform plan \
  -var-file="terraform.tfvars" \
  -out=prod.plan
```

---

### 5️⃣ Apply Deployment

**Local apply:**

```bash
terraform apply "prod.plan"
```

**OR**

Allow **GitLab CI** to run the `apply` stage automatically.

---

### 6️⃣ Destroy Infrastructure (If Needed)

**Local destroy:**

```bash
terraform destroy \
  -var-file="terraform.tfvars" \
  --auto-approve
```

**Via GitLab CI:**

Set pipeline variable:

```
TERRAFORM_DESTROY=YES
```

This triggers the `destroy` job in the pipeline.

---

## CI Pipeline Stages

1. **version-check**
2. **init**
3. **fmt / validate**
4. **plan**
5. **apply**
6. **destroy** (manual / variable-driven)

---

## Notes

* Ensure AWS permissions allow:

  * VPC
  * EC2
  * IAM
  * ELB
  * NAT
  * S3 backend access
* Keep `terraform.tfvars` secure (avoid committing secrets).
* Use GitLab CI variables for sensitive values.

---
