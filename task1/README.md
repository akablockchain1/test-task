# Terraform AWS EC2 Deployment with Nginx

This project contains Terraform configuration files to deploy an EC2 instance running Ubuntu 20.04 in AWS with Nginx installed and running.

## Prerequisites

- Terraform installed on your local machine. You can download it [here](https://www.terraform.io/downloads.html).
- AWS CLI installed and configured with your credentials. You can follow the installation guide [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
- An AWS account with the necessary permissions to create EC2 instances and security groups.
- Git installed on your local machine.

## Setup

### Step 0: Create ssh-key
```sh
ssh-keygen -t rsa -b 4096 -f ~/.ssh/terraform_aws_key
```

### Step 1: Clone the repository

Clone the repository to your local machine.

```sh
git clone https://github.com/your-repo/terraform-aws-ec2-nginx.git
cd terraform-aws-ec2-nginx

terraform init
terraform plan
terraform apply
```

### Step 2: Initialize Terraform
Initialize the Terraform working directory. This step downloads the necessary provider plugins.
```sh
terraform init
```

### Step 3: Review the deployment plan
Generate and review the execution plan. This shows what actions Terraform will take to deploy the infrastructure.
```sh
terraform plan
```

### Step 4: Apply the configuration
Apply the Terraform configuration to create the resources in AWS.
```sh
terraform apply
```
Type yes when prompted to confirm the deployment.

### Step 5: Retrieve the Public IP
After the apply step completes, Terraform will output the public IP address of the EC2 instance. You can also retrieve it using the AWS Management Console.

### Step 6: Test the Nginx Installation
Open a web browser and navigate to the public IP address of the EC2 instance. You should see the default Nginx welcome page, indicating that Nginx is successfully installed and running.

### Clean Up
To destroy the resources created by Terraform, run the following command:
```sh
terraform destroy
```
Type yes when prompted to confirm the destruction.

### Troubleshooting
If you encounter any issues, ensure that:
- Your AWS credentials are correctly configured.
- The AMI ID specified in the main.tf file is correct and available in the eu-central-1 region.
- Your security group rules are properly set to allow inbound traffic on port 22 (SSH) and port 80 (HTTP).
