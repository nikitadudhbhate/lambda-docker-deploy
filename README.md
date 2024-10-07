# AWS Lambda Deployment with Docker and GitHub Actions

This repository contains a Python-based AWS Lambda function packaged as a Docker container. The deployment process is automated using GitHub Actions, which builds the Docker image, pushes it to Amazon Elastic Container Registry (ECR), and updates the Lambda function.

## Prerequisites

- **AWS Account**: Ensure you have an AWS account.
- **IAM User**: Create an IAM user with the required permissions for ECR and Lambda.
- **GitHub Repository**: Clone or create a GitHub repository for this project.
- **Docker**: Install Docker on your local machine.
- **AWS CLI**: Install and configure the AWS CLI with your credentials.

## Steps

### step1. Write the Python Lambda Function

### step2. Containerize the Lambda Function with Docker
- Create a Dockerfile to define the container image:

### step3. Build and Push the Docker Image to Amazon ECR
#### Step 3.1: Create an Amazon ECR Repository
- Create an ECR repository where the Docker image will be stored:
```
aws ecr create-repository --repository-name lambda-docker-repo
```
- Make note of the repository URI from the output (e.g., <aws-account-id>.dkr.ecr.<region>.amazonaws.com/lambda-docker-repo).

#### Step 3.2: Log in to Amazon ECR
- Authenticate Docker to the Amazon ECR repository:
```
aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com
```
- Replace <your-region> and <your-account-id> with your specific values.

#### Step 3.3: Build and Tag the Docker Image
- Build the Docker image:
```
docker build -t lambda-docker-repo .
```
- Tag the image to point to your ECR repository:
```
docker tag lambda-docker-repo:latest <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/lambda-docker-repo:latest
```

#### Step 3.4: Push the Docker Image to Amazon ECR
- Push the Docker image to the ECR repository:
```
docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/lambda-docker-repo:latest
```

### step4. Automate Deployment with GitHub Actions
#### Step 4.1: Create GitHub Secrets
- Go to your GitHub repository.
- Navigate to Settings > Secrets > Actions.
- Add the following secrets:
  - `AWS_ACCESS_KEY_ID: Your AWS Access Key.`
  - `AWS_SECRET_ACCESS_KEY: Your AWS Secret Key.`
  - `AWS_REGION: Your AWS region (e.g., us-east-1).`
  - ` AWS_ACCOUNT_ID: Your AWS account ID.`
  - `LAMBDA_FUNCTION_NAME: The name of your Lambda function.`

#### Step 4.2: Create a GitHub Actions Workflow
- In your repository, create a directory: .github/workflows.
Inside that directory, create a file named deploy.yml

### step 5. Test the Lambda Function
- Once the Lambda function has been deployed, you can trigger and test it via API Gateway or an S3 event:

- Option 1: Trigger with API Gateway
Set up an API Gateway to trigger the Lambda function.
Test the endpoint by making an HTTP request to the API Gateway URL.
- Option 2: Trigger with S3 Event
Configure an S3 bucket to trigger the Lambda function on object creation events.
Upload a file to the S3 bucket to trigger the Lambda function.
