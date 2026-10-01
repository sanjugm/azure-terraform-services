# Azure Terraform Services

Terraform practice repository for creating Azure infrastructure independently.

## Services
- VM — Linux VM with VNet, subnet, NSG, NIC and public IP
- Storage Account — Storage account with private blob container and versioning
- Key Vault — RBAC-enabled Azure Key Vault
- App Service — Linux App Service and App Service Plan
- AKS — AKS cluster with system-assigned managed identity and Azure CNI overlay

## Structure
```
vm/
storage-account/
key-vault/
app-service/
aks/
```

Each folder is an independent Terraform root and therefore has its own state.

## Run any service
```bash
az login
cd <service-folder>
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

Destroy test resources when finished:
```bash
terraform destroy
```

Never commit real passwords, secrets, private keys or `terraform.tfvars`.
