# Hello World

## Overview
Spring boot application to print hello world.

## Technologies Used
- Java SDK 18
- Spring Boot
- Docker/ Docker hub
- Maven
- Github workflows
- AWS: ECS/ App runner service/ ECR

## Features
- Prints hello world when run locally after navigating to http://localhost:8080/
- Health checkpoint is at http://localhost:8080/actuator/health
- This application is also dockerized. Run `docker compose up` to start the docker container.
- It has github workflows(all triggered on push to main branch) to:
  - Build and test the project
  - Build and push the new image to github packages and docker hub (This needs to change to Callibrity's docker hub)
  - Build and push the image to AWS ECR and deploys the app to AWS.
    - ECS: http://18.189.22.83:8080/
    - App runner service: https://dbfturffex.us-east-2.awsapprunner.com/

## Deployment to AWS 
- DEPLOYMENT TO ECS:
1) Navigate to the AWS console: https://us-east-2.console.aws.amazon.com/console/home?nc2=h_ct&region=us-east-2&src=header-signin#
2) In the console, go to ECR. Create a new private repository.
3) Go to ECS.
   - Create a new cluster. Choose Fargate as the infrastructure.
   - Create a new task definition: 
   Choose the task role as ecsTaskExecutionRole. In the IAM console, make sure it has the appropriate permissions.
   In the container details, add the repository URL from step #2.
4) Once the task is created, copy the JSON and paste into the task_deinition.json file in your github repo.
5) Before creating the service that triggers the deployment, create the load balancer, target groups and security groups in EC2.
   - Create a new Application Load balancer. Make it internet facing with IPv4 address type. In network mapping choose all the zones. 
   Choose the default security group(we'll add rules to it later).
   - In EC2 security groups, add inbound rules to allow traffic from ports 80 and 8080.
   - Create new target group to route traffic from the load balancer to your application. Choose the target type as IP, HTTP port as 8080. Register the created target group with your application load balancer.
6) Choose the cluster created in 3a and create a new service. Choose the load balancer and target group created in EC2 earlier.

- DEPLOYMENT TO AWS APP RUNNER:
In the AWS Console, navigate to App Runner Service. 
Choose container registry and ECR as the source. 
Choose the ECR repository created earlier. 
Select Automatic deployments. 
Specify port 8080. 
Once created, deploy the service. 
