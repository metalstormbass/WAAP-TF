# WAAP-TF
Automatically Deploy WAAP and Vulnerable Web App


This playbook will install Nginx and Docker on a Ubuntu VM within Azure. 

It will then download [OWASP Juice Shop](https://github.com/bkimminich/juice-shop) and run as a container.

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

Edit the variables as required. You can create a terraform.tfvars file and fill it our like below. Otherwise, you will be prompted for the information.

```hcl
victim_company = "MikeNet"
victim-network-vnet-cidr = "10.22.0.0/16" 
victim-network-subnet-cidr = "10.22.0.0/24" 
environment = "Staging"
vulnvm-name = "VulnServer"
username = "mike" 
password = "Vpn123vpn123!"
```



In vuln_bootstrap.sh (#Username for vulnerable server. Make sure that this is the same as the username in terraform.tfvars) Insert your WAAP token.

```hcl
#Variables
name=mike 
token=insert_token_here
```

NOTE: Comment out the token variable if you are not deploying WAAP

Run the following commands in Terraform:

```hcl
terraform init
```

then:

```hcl
terraform apply
```

Finally, wait until Terraform has completed. Then wait an addtional 5-10 mins for the VM to complete bootstrapping.



To destroy, you need to run:

```hcl
terraform destroy
```

## Issues:

At this point, sometimes you need to run the destroy  command several (~3) times for the environment to be completely removed. This appears to be a bug in the dependency handling within Terraform.
