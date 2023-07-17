# **Terraform-EC2-RDS**

![bash-terraform drawio (2)](https://github.com/Ab-Rehman99/Terraform-EC2-RDS/assets/85974328/f27e72ba-40a5-4fef-b8d7-049f16128e41)

This repository contains  Terraform configurations and bash scripts to create an EC2 instance in AWS running a PHP Apache application and a MySQL RDS instance as the database.

## **Prerequisites**


Before running the Terraform scripts, you need to have the following prerequisites installed and configured:

1. **[AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)**
2. **[Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)**

Make sure you have properly configured AWS programmatic access using the **`aws configure`** command. This will require your AWS Access Key ID, Secret Access Key, and default region.

## **Usage**

1. Run the **`bash_terraform.sh`** script to create the infrastructure in AWS:
    
    ```
    ./bash_terraform.sh
    
    ```
    
    This script will initialize Terraform, apply the configuration, and store the instance IP and DB endpoint in the **`output.txt`** file.
    
2. Once the infrastructure is created, you can access the deployed PHP Apache application by navigating to the EC2 instance's public IP address in your web browser.
3. To destroy the infrastructure and clean up all the resources, run the **`bash_destroy.sh`** script:
    
    ```
    ./bash_destroy.sh
    
    ```
    
    This script will destroy the Terraform-managed resources and prompt for confirmation before proceeding.
    

## **Notes**

- The **`terraform.tfstate`** file is automatically generated and contains the state of your infrastructure. Do not modify or delete this file manually, as it is used by Terraform to manage resources.
- Make sure to secure the **`terraform.tfstate`** file and any sensitive information stored in the **`terraform.tfvars`** file.
- Refer to the official Terraform documentation for more details on how to customize and extend this configuration: **[Terraform Documentation](https://www.terraform.io/docs/index.html)**
- For any issues or questions related to this repository, please open an issue on the **[GitHub repository](https://github.com/your-username/terraform-ec2-rds/issues)**.

## **License**

This project is licensed under the **[MIT License](https://chat.openai.com/LICENSE)**.

