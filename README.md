# Terraform AWS Infrastructure

Terraform configurations to provision core AWS infrastructure from scratch.

## What this provisions
- VPC with public and private subnets
- EC2 instances
- Security Groups with controlled ingress/egress rules
- IAM roles and policies

## Tools
- Terraform
- AWS (VPC, EC2, IAM, Security Groups)

## How to use
```bash
terraform init
terraform plan
terraform apply
```

## Part of YumCart DevOps Project
This infrastructure supports the YumCart application deployment.
- App & CI/CD repo: https://github.com/RakshithaChandana/yum-cart-dockerization
- Kubernetes & ArgoCD repo: https://github.com/RakshithaChandana/yum-cart-k8s-deployment
