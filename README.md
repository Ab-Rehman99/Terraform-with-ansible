
## **Automation in AWS Infrastructure and Configuration using Terraform and Ansible**
![Terraform-with-ansible drawio (3)](https://github.com/Ab-Rehman99/Terraform-with-ansible/assets/85974328/ce0857bd-3cb7-4994-ac4a-116e30319669)

This guide will walk you through setting up Ansible on an AWS EC2 instance (master server) and using it to manage and configure other EC2 instances (slave nodes) which is created through terraform. 

We will  assume that you have already created an IAM user with the necessary permissions and have set up the AWS CLI.

**Prerequisites:**

1. Install AWS CLI on Ansible master server following the official guide: [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
2. Create an IAM user in AWS with appropriate permissions for infrastructure provisioning (using Terraform). Use `aws configure` on the master server to set the IAM user's access ID and secret key.
3. Generate an SSH key pair and store the private key as `ansible-key.pem` in `~/.ssh/` directory. Set correct permissions on the private key file:

```
nano ~/.ssh/ansible-key.pem  # Paste the private key content and save the file
chmod 600 ~/.ssh/ansible-key.pem
chown ubuntu:ubuntu /home/ubuntu/.ssh/ansible-key.pem

```

4. Verify the SSH connection from the master server to the slave nodes:

```
sudo ssh -i ~/.ssh/ansible-key.pem ubuntu@[worker-public-ip]

```

## **Run the Bash Script**

```jsx
chmod +x bash-start.sh
./bash-start.sh
```

Check whether the master can ping the slave nodes or not using:

```
ansible -all -i [path/to/hosts/file] --private-key=[path/to/ssh-key-file] -m ping -u [user]
```

Example:

```jsx
ansible all -i /home/ubuntu/ansible/hosts --private-key=/home/ubuntu/.ssh/ansible-key -m ping -u ubuntu
```

## **Run the Ansible Playbook**

Run the Ansible playbook to perform desired configurations on the slave nodes:

```
ansible-playbook [playbook.yml] -i [path/to/hosts/file] --private-key=[path/to/ssh-key-file]

```

Replace `<playbook.yml>` with the name of your Ansible playbook.

**Example:**

```
ansible-playbook /home/ubuntu/ansible/nginx.yml -i /home/ubuntu/ansible/hosts --private-key=/home/ubuntu/.ssh/ansible-key.pem

```

**Note:**

- Adjust the paths and file names according to your specific setup.
- The example assumes that you have a playbook named `nginx.yml` and an inventory file named `hosts` in the `/home/ubuntu/ansible/` directory.

Congratulations! You have setup the automation of AWS infrastructure provisioning and configuration management using bash, terraform and ansible.
