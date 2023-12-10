# docker-ecr-github-action
This project involves using GitHub Actions to automate the uploading of Docker images to AWS ECR. Define a workflow for the efficient, safe, and optimized creation and deployment of images by creating a GitHub repository, writing a Dockerfile, configuring AWS ECR, and more.

## Pre-Requisites
-> Aws account
-> You must have knowledge of GitHub, and Git commands
-> Basic knowledge of GitHub actions, CI/CD, YAML

## GitHub Actions Workflow

We use GitHub Actions for continuous integration and deployment. The workflow is triggered on each push to the main branch.

### Workflow Steps:

- **Step 1:** Check out the code.
- **Step 2:** Configure AWS credentials using GitHub repository secrets.
- **Step 3:** Login to Amazon ECR.
- **Step 4:** Build, tag, and push the Docker image to Amazon ECR.

### Secrets:

To set up the GitHub Actions workflow, you need to add the following secrets in your repository settings:

- `AWS_ACCESS_KEY_ID`: Your AWS access key ID.
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key.

# Steps

**_Step # 1_**

  1.1: **Create a New GitHub Repository**
        First of all, you need to create a new repository on GitHub or use an existing one if you prefer.

  1.2 : **Initialize Repository with an Application**
        Initialize the repository with an application, in a programming language of your choice here in this case is Python.

  1.3: **Add Dockerfile to the Root**
Create and add a Dockerfile to the root of your project. This Dockerfile will be responsible for building a Docker image for your application.

**_Step #2_**
        2.1: **Write a Dockerfile**
        - Craft a Dockerfile that builds a Docker image for your application.

        2.2: **Optimize the Dockerfile**
        - Optimize the Dockerfile for size and build time.

        2.3: **Consider Multi-stage Builds**
        - Consider using multi-stage builds to reduce the final image size.

**_Step #3_**
  **3.1: Create an AWS ECR Repository**
     - Go to the AWS Management Console.
     - Navigate to Elastic Container Registry (ECR) and create a new repository to store Docker images.

  **3.2: Configure IAM Roles and Policies**
    - Create an IAM role with the necessary permissions to push images to ECR.
    - Attach this role to your GitHub Actions workflow.


**_Step #4_**
**4.1: Develop GitHub Actions Workflow**
    - Create a .github/workflows directory in your repository.
    - Inside this directory, add a YAML file (e.g., main.yml) to define the workflow.
    ```
                          name: Build and push image to ECR
                      
                      on:
                        push
                      
                      jobs:
                        build:
                          name: Build Image
                          runs-on: ubuntu-latest
                      
                          steps:
                          - name: Check out code
                            uses: actions/checkout@v2
                      
                          - name: Configure AWS credentials
                            uses: aws-actions/configure-aws-credentials@v1
                            with:
                              aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
                              aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
                              aws-region: ap-south-1
                      
                          - name: Login to Amazon ECR
                            id: login-ecr
                            uses: aws-actions/amazon-ecr-login@v1
                      
                          - name: Build, tag, and push image to Amazon ECR
                            env:
                              ECR_REGISTRY: ${{ steps.login-ecr.outputs.registry }}
                              ECR_REPOSITORY: docker-ecr-github-action
                              IMAGE_TAG: demo_sample_image
                            run: |
                              docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG .
                              docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
    ```
**4.2: Add Secrets to GitHub Repository**
    - In your GitHub repository, go to Settings > Secrets.
    - Add the following secrets:
    - AWS_ACCESS_KEY_ID
    - AWS_SECRET_ACCESS_KEY
    - AWS_REGION
    - AWS_REGISTRY_URI (this should be the URI of your ECR repository)



**_Step #5_**
**5.1: Implement Security Best Practices**
    - Avoid hardcoding sensitive information in your code.
    - Use GitHub Secrets to securely store AWS credentials.

**_Step #6_**

    **Bonus #1: Implement Image Scanning for Vulnerabilities**
      - Use AWS ECR image scanning features to identify vulnerabilities in your Docker images.This initializes CodeQL for security scanning. GitHub Code Scanning will automatically analyze your codebase for security vulnerabilities.Results will be available in the "Security" tab of your GitHub repository.
              ```
              yaml
               - name: Bonus Task - GitHub Code Scanning
                uses: github/codeql-action/init@v1
              ```
           ![image](https://github.com/reshmaq/docker-ecr-github-action/assets/121748445/8f314879-5523-4b7d-9216-ca66bb42b495)

    **Bonus #2: Set Up Notification upon Successful Upload or Failure**
      - Use GitHub Actions notifications or external services like email to notify on successful image uploads or failures.
           ```
              yaml
               - name: Bonus Task - Notify on Success or Failure
                  if: always()
                  run: |
                    if [ ${{ job.status }} == 'success' ]; then
                      echo "Success! Docker image successfully pushed to ECR."
                    else
                      echo "Failure! Docker image push to ECR failed."
                    fi
              ```
          

### Local Development:

If you want to run the workflow locally, follow these steps:

1. Install the required dependencies.
2. Set up AWS credentials.
3. Run the workflow locally using the GitHub CLI.

### Troubleshooting:

If you encounter any issues, check the GitHub Actions logs for detailed information.


