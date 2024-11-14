# AWS Infrastructure with Terraform

This project implements a multi-tier AWS infrastructure using Terraform modules. The infrastructure includes VPC networking, security groups, compute resources, and load balancers configured for high availability across multiple availability zones.

## Architecture Overview

The infrastructure consists of:
- VPC with public and private subnets across two availability zones
- Security groups for different tiers
- EC2 instances in both public and private subnets
- Internal and external load balancers for traffic distribution

## Prerequisites

- Terraform >= 0.12
- AWS CLI configured with appropriate credentials
- AWS account with necessary permissions

## Module Structure
├── main.tf
├── provider.tf
└── modules/
    ├── networking/
    ├── security_groups/
    ├── compute/
    └── loadbalancer/

## Modules Description

### Networking Module
Configures the base network infrastructure:
- VPC with CIDR: 10.0.0.0/16
- Public subnets: 10.0.1.0/24, 10.0.3.0/24
- Private subnets: 10.0.0.0/24, 10.0.2.0/24
- Availability zones: us-east-1a, us-east-1b

### Security Groups Module
Manages security group configurations:
- Proxy security groups
- HTTP security groups
- Load balancer security groups

### Compute Module
Handles EC2 instance provisioning:
- Instance type: t2.micro
- Instances in both public and private subnets
- Integration with load balancers

### Load Balancer Module
Configures load balancers:
- External load balancer in public subnets
- Internal load balancer in private subnets
- Health checks and target group configurations