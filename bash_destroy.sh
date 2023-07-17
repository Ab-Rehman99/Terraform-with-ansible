# Move into the cloned directory
echo "Moving into the cloned directory..."
cd Terraform-EC2-RDS

terraform destroy -auto-approve

echo "Terraform destroy completed."