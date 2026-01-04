# AWS Setup Guide for Terraform

## 1. Create AWS Account
If you don't have one, go to [aws.amazon.com](https://aws.amazon.com/) and create a free account.

## 2. Create an IAM User (Recommended)
Avoid using the root account.
1.  Go to the **IAM Console**.
2.  Click **Users** -> **Create user**.
3.  Name: `terraform-user`.
4.  Permissions: Attach policies directly -> **AdministratorAccess** (for this POC only).
5.  Create User.

## 3. Create Access Keys
1.  Click on the newly created user (`terraform-user`).
2.  Go to **Security credentials** tab.
3.  Scroll to **Access keys**.
4.  Click **Create access key**.
5.  Select **Command Line Interface (CLI)**.
6.  Copy the **Access Key ID** and **Secret Access Key**. (Save them securely!)

## 4. Configure Local Environment (PowerShell)
Run these commands in your PowerShell terminal (replace with your keys):

```powershell
$env:AWS_ACCESS_KEY_ID="AKIAxxxxxxxxxxxx"
$env:AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiVYEXAMPLEKEY"
$env:AWS_DEFAULT_REGION="eu-west-3"
```

## 5. Run Terraform
Now you can provision the infrastructure:

```powershell
cd terraform
..\bin\terraform.exe init
..\bin\terraform.exe plan
..\bin\terraform.exe apply
```
