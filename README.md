# KAS
Terraform Code for VPC Design



### The Terraform resources will consists of following structure

```
├── main.tf                   // The primary entrypoint for terraform resources.
├── vars.tf                   // It contain the declarations for variables.
├── output.tf                 // It contain the declarations for outputs.
├── terraform.tfvars          // The file to pass the terraform variables values.
```



1. VPC - creating VPC in AWS
2. networks - creating AWS Public and Private SUbnet
3. s_groups - creating network security group, setting desired security rules and associating them to subnets
4. bastion - creating  virtual machines to connect to Private Instances
5. S3 - creating S3 bucket in AWS instance

All the stacks are placed in the modules folder and the variable are stored under **terraform.tfvars**

To run the code you need to append the variables in the terraform.tfvars

Each module consists minimum two files: main.tf, vars.tf

resourcegroup and networking modules consists of one extra file named output.tf

## Deployment

### Steps

**Step 0** `terraform init`

used to initialize a working directory containing Terraform configuration files

**Step 1** `terraform plan`

used to create an execution plan

**Step 2** `terraform validate`

validates the configuration files in a directory, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc

**Step 3** `terraform apply -var-file=terraform.tfvars`

used to apply the changes required to reach the desired state of the configuration
