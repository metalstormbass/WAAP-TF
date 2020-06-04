# WAAP-TF
Automatically Deploy WAAP and Vulnerable Web App


This playbook will install Nginx and Docker on a Ubuntu VM within Azure. 

It will then download [OWASP Juice Shop] (https://github.com/bkimminich/juice-shop) and run as a container.

Finally, it will deploy the WAAP and register it.


## Prerequisites

Terraform
Azure CLI

## Usage:

Clone the repository

```hcl
git clone https://github.com/metalstormbass/WAAP-TF.git
```

Ensure that you have Azure CLI installed. Once installed run the following command in Powershell.

```hcl
az login
```

Edit the variables as required. Review terraform.tfvars and vuln_bootstrap.sh

terraform.tfvars

```hcl
victim_company = "MikeNet"
attacker_company = "EvilCorp"
victim-network-vnet-cidr = "10.1.0.0/16"
victim-network-subnet-cidr = "10.1.0.0/24"
attacker-network-vnet-cidr = "10.2.0.0/16"
attacker-network-subnet-cidr = "10.2.0.0/24"
environment = "Staging"
vulnvm-name = "VulnServer"
username = "mike"
password = "Vpn123vpn123!"
```

vuln_bootstrap.sh

```hcl
#Variables
name=mike
token=<insert WAAP token here>
```

Run the following commands in Terraform:

```hcl
terraform init
```

then:

```hcl
terraform apply
```

Finally, wait until Terraform has completed. Then wait an addtional 5-10 mins for the VM to complete bootstrapping.

## Issues:
To destroy, you need to run:

```hcl
terraform destroy
```

At this point, you need to run it several (~3) times for the environment to be completely removed. This will be addressed soon.