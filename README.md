# Terraform Multi-Environment Project

This project demonstrates a best-practice directory structure for creating multi-environment infrastructure using Terraform.

## Structure

```
.
├── environments
│   ├── dev  # Development environment configuration
│   └── prod # Production environment configuration
└── modules
    ├── networking # Shared networking module
    └── compute    # Shared compute module
```

## Usage

### Prerequisites
- Terraform installed
- AWS Credentials configured

### Running Terraform

**Development:**
```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

**Production:**
```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

### Automation
A `Makefile` is included for common tasks:
- `make fmt`: Format all Terraform files.
- `make validate-all`: Validate configuration for both environments.
