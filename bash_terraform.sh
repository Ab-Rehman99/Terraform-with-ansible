#!/bin/bash

echo "creating ansible inventory file"
mkdir /home/ubuntu/ansible
touch /home/ubuntu/ansible/hosts
# install ansible
echo "installing ansible"
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y 

#install terraform
echo "installing terraform"
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform

# Clone the repository
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
# Wait for 3 minutes before updating the Ansible inventory
#echo "Waiting for 3 minutes..."
#sleep 3m
# Ansible inventory file
ansible_inventory="/home/ubuntu/ansible/hosts"
sudo apt-get install jq -y
# Function to retrieve IP addresses from Terraform and update the inventory file
update_inventory() {
  # Retrieve the public IP addresses using Terraform output in JSON format
  public_ips=$(terraform output -json public_ip | jq -r '.[]')

  # Retrieve the instance names using Terraform output in JSON format
  instance_names=$(terraform output -json instance_names | jq -r '.[]')

  # Write the IP addresses and instance names to the inventory file
  echo "[webServers]" > "$ansible_inventory"
  i=0
  while IFS= read -r ip; do
    echo "${instance_names[$i]} ansible_host=$ip" >> "$ansible_inventory"
    i=$((i + 1))
  done <<< "$public_ips"
  echo "" >> "$ansible_inventory"
  echo "[all:vars]" >> "$ansible_inventory"
  echo "ansible_python_interpreter=/usr/bin/python3" >> "$ansible_inventory"
}

# Call the function to update the inventory file
update_inventory