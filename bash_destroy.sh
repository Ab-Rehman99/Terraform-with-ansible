# Move into the cloned directory
echo "Moving into the cloned directory..."
cd Terraform-with-ansible
cd Terraform-scripts

terraform destroy -auto-approve

echo "Terraform destroy completed."