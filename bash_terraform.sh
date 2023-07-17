#!/bin/bash

# Clone the repository
mkdir /home/ubuntu/ansible
touch /home/ubuntu/ansible/hosts

echo "Cloning the repository..."
git clone https://github.com/Ab-Rehman99/Terraform-with-ansible.git

# Move into the cloned directory
echo "Moving into the cloned directory..."

cd Terraform-with-ansible
cd Terraform-scripts

# Run Terraform and save the output to a file
echo "Initializing Terraform..."
terraform init
echo "Applying Terraform configuration..."
terraform apply -auto-approve
echo "Terraform output saved..."
terraform output > /home/ubuntu/output.txt

# Ansible inventory file
ansible_inventory="home/ubuntu/ansible/hosts"

# Function to retrieve IP addresses from Terraform and update the inventory file
update_inventory() {
  # Retrieve the public IP addresses using Terraform output
  public_ips=$(terraform output -raw public_ips)

  # Write the IP addresses to the inventory file
  echo "[webServers]" > "$ansible_inventory"
  while IFS= read -r ip; do
    echo "node ansible_host=$ip" >> "$ansible_inventory"
  done <<< "$public_ips"
  echo "" >> "$ansible_inventory"
  echo "[all:vars]" >> "$ansible_inventory"
  echo "ansible_python_interpreter=/usr/bin/python3" >> "$ansible_inventory"
}

# Call the function to update the inventory file
update_inventory