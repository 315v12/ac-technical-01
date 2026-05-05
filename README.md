# ac-technical-01
# Denis Ahmetasevic
# May 2026
# ActiveCampaign - Techinical Assignment
# trigger pipeline

# Terraform CI/CD Pipeline for AWS Infrastructure and Okta Integration

## Overview

This project implements a CI/CD pipeline for managing cloud infrastructure using Terraform and GitHub Actions. It provisions AWS EC2-based compute infrastructure and includes a design-ready integration layer for Okta identity management and AWS Secrets Manager for secure secret handling.

The system demonstrates infrastructure-as-code best practices including modular Terraform design, remote state management, and automated CI/CD workflows.

---

## Architecture

### High-Level Components

- GitHub Actions – CI/CD automation layer
- Terraform – Infrastructure as Code engine
- AWS S3 Backend – Remote state storage
- AWS EC2 – Compute layer via reusable module
- AWS Secrets Manager – Secure secret storage (e.g., Okta API tokens)
- Okta Module (design-ready) – Identity provider integration layer

---

## Repository Structure

```text id="repo-structure-final"
terraform/
├── environments/
│   └── dev/
│       ├── backend.tf
│       ├── main.tf
│       ├── terraform.tfstate (local artifact from transition to S3 backend)
│       └── terraform.tfstate.backup
│
└── modules/
    ├── ec2/
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── okta/
    └── secrets/

.github/
└── workflows/
    └── terraform.yml
