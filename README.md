# Alarm Page Deployment on AWS Using Terraform

This project demonstrates how to deploy a static alarm page to AWS using Terraform. It utilizes Amazon S3 for hosting the static site and other AWS services to manage the infrastructure.

## Prerequisites

Before getting started, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)

Additionally, make sure your AWS account is set up, and you have configured the AWS CLI with appropriate credentials.

---

## Setup Instructions

Follow the steps below to deploy the project:

### 1. Clone the Repository

Start by cloning the repository to your local machine:

```bash
git clone https://github.com/satyanarayanareddy25/alarm-page-deployment-aws.git
```

### 2. Set Up AWS Credentials

Ensure that your AWS credentials are configured properly. If you haven’t done this yet, use the AWS CLI to configure them:

```bash
aws configure
```

You will be prompted to enter:

- AWS Access Key ID
- AWS Secret Access Key
- Default region name
- Default output format

### 3. Initialize Terraform

Navigate to the `terraform-s3` directory and initialize Terraform:

```bash
terraform init
```

This will download the necessary provider plugins and initialize your Terraform configuration.

### 4. Review and Plan Terraform Configuration

Before applying the configuration, run `terraform plan` to review the Terraform plan:

```bash
terraform plan
```

This will show you the execution plan and the resources that will be created.

### 5. Apply Terraform Configuration

After reviewing the plan, apply the configuration to provision the resources:

```bash
terraform apply
```

Terraform will prompt you to confirm the execution. Type `yes` to proceed. This will create the necessary AWS infrastructure, including an S3 bucket configured for static website hosting.

### 6. Upload Build Files to S3

Once the Terraform configuration has been successfully applied, upload the build files of your alarm page to the newly created S3 bucket.

Navigate to the `build/` folder:

```bash
cd ../build
```

Then, upload the contents of the `build/` folder to the S3 bucket:

```bash
aws s3 sync . s3://<your-s3-bucket-name> --delete
```
or 
```bash
aws s3 cp . s3://<your-s3-bucket-name>/ --recursive
```


Replace `<your-s3-bucket-name>` with the actual name of the S3 bucket created by Terraform.

### 7. Apply Changes

Once the build files are uploaded, re-apply the changes if necessary:

```bash
terraform apply
```

This will ensure the infrastructure and configurations are updated with the new settings.

### 8. Check Your Static Site

Once the files have been uploaded and changes are applied, you can access your static website using the S3 website endpoint. The URL should look something like this:

```bash
http://<your-s3-bucket-name>.s3-website-<AWS-region>.amazonaws.com
```

### 9. Cleanup
To delete the resources created, run:
```bash
terraform destroy
```

---

## Challenge: Public Access Block Error

When applying the Terraform configuration for the first time, you may encounter an error related to the `aws_s3_bucket_public_access_block` resource. The error occurs because the public access block setting is set to `true` by default. This setting prevents any public access to the S3 bucket. Since you need to serve your static website publicly, the policy needs to be updated.

Here is how you should change the `aws_s3_bucket_public_access_block` resource:

### Corrected Configuration:

```hcl
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket              = aws_s3_bucket.react_app_bucket.bucket
  block_public_policy = false  # Allow public policy for the S3 bucket
}
```

This change sets `block_public_policy` to `false`, which allows public access to the S3 bucket and will resolve the error when applying the Terraform configuration for the first time.

---


## Notes

- **React Build**: The `build/` folder contains the production-ready React app, which will be uploaded to S3 for hosting.
- **Terraform**: The Terraform configuration handles the creation of the S3 bucket, sets up the bucket for static web hosting, and provisions other necessary resources.
- **AWS Resources**: The infrastructure in this project uses Amazon S3 for static web hosting. Ensure your bucket has the correct permissions for public access.



## Contributing

If you'd like to contribute to `alarm-page-deployment-aws`, here are some guidelines:

1. Fork the repository.
2. Create a new branch for your changes.
3. Make your changes.
4. Write tests to cover your changes.
5. Run the tests to ensure they pass.
6. Commit your changes.
7. Push your changes to your forked repository.
8. Submit a pull request.

---



## Authors and Acknowledgment

`alarm-page-deployment-aws` was created by **[Satyanarayana Reddy](https://github.com/satyanarayanareddy25)**.



---



## Contact

If you have any questions or comments about `terraform_linux`, please contact **[Satyanarayana Reddy](annapureddysatya00789@gmail.com)**.

---

## Conclusion

That's it! 

