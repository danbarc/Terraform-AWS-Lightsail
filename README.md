# Thermtech Infrastructure - Terraform

This repository contains the Infrastructure as Code (IaC) for Thermtech's Website and Intranet using **AWS Lightsail**, **Route 53**, and **Amazon SES**.

## Architecture

- **Lightsail Instance**: Debian + Apache + MySQL (LAMP)
- **Static IP**: Fixed public IP
- **Route 53**: DNS management with Microsoft 365 integration
- **Amazon SES**: Transactional emails from WordPress
- **Two websites**: Main site (`thermtech.com.br`) + Portal (`portal.thermtech.com.br`)

## Project Structure

```bash
.
├── main.tf                    # Lightsail instance + Static IP
├── providers.tf               # AWS Provider
├── route53.tf                 # DNS records (Microsoft 365 + sites)
├── ses.tf                     # Amazon SES + IAM SMTP user
├── outputs.tf                 # Important outputs
├── variables.tf
├── terraform.tfvars.example
└── README.md

'''
## Prerequisites

- AWS Account with Lightsail enabled
- Domain thermtech.com.br delegated to Route 53
- SSH Key pair 

## How to Deploy
# 1. Clone the repository
git clone https://github.com/yourusername/thermtech-terraform.git
cd thermtech-terraform

# 2. Copy example variables
cp terraform.tfvars.example terraform.tfvars

# 3. Initialize and deploy
terraform init
terraform plan
terraform apply

## Important Notes

- Never commit terraform.tfvars or any sensitive files
- SES domain verification and DKIM records are automatically managed
- Microsoft 365 MX, SRV, and DKIM records are preserved

## Security

- IAM user with least privilege for SES SMTP
- Static IP for stable hosting
- Let's Encrypt SSL certificates

## Maintenance

- Backups: Use Duplicator + EBS snapshots
- Updates: Regular apt update && apt upgrade
- Monitoring: AWS Lightsail console + CloudWatch