# WAAP-TF
## Automatically Deploy WAAP and Vulnerable Web App
Written by Michael Braun


This playbook will install Nginx and Docker on a Ubuntu VM within Azure. 

It will then download [OWASP Juice Shop](https://github.com/bkimminich/juice-shop) and run as a container.

Finally, it will deploy the WAAP and register it.


## Prerequisites

[Github Account](https://github.com) <br>
[Azure Account](https://portal.azure.com) <br>
[Terraform Cloud Account](https://terraform.io) <br>
[Check Point Cloud Portal](https://portal.checkpoint.com) - Need WAAP Token <br>

## Usage:

Fork the repository into your own Github.

Then:

1. Login to Terraform Cloud and create a new workspace.<br> 

2. Select Version Control Workflow <br>

![](/images/t1.PNG)

3. Connect it to Github <br>

![](/images/t2.PNG)

4. Select  the WAAP-TF Repository. <br>

![](/images/t3.PNG)


5. Fill out the Terraform Variables. There are two kinds, Terraform Variables and Environemnt Variables<br>

<b> Environment Variables </b>

![](/images/t5.PNG)

This is the app registration information

ARM_CLIENT_ID = client ID<br>
ARM_CLIENT_SECRET = secret<br>
ARM_TENANT_ID = tenant ID<br>
ARM_SUBSCRIPTION_ID = subscription ID<br>



<b> Terraform Variables </b><br>

For the Terraform Variables, you need to match the variables defined in the variables.tf file that do not have a default value associated with it. By default you have to define:<br>

victim_company<br>
username<br>
password<br>
token<br>


![](/images/t4.PNG)


Finally, you need to Queue the plan in Terraform Cloud:

![](/images/t6.PNG)


## Destruction

Click on Setting > Destruction and Deletion > Queue Destroy Plan

