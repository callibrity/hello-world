# Hello World

## Overview
Spring boot application to print hello world.

## Technologies Used
- Java SDK 18
- Spring Boot
- Docker/ Docker hub
- Maven
- Github workflows
- Terraform
- AWS: ECS/ App runner service/ ECR

## Features
- Prints hello world when run locally after navigating to http://localhost:8080/
- Health checkpoint is at http://localhost:8080/actuator/health
- This application is also dockerized. Run `docker compose up` to start the docker container.
- It has github workflows(all triggered on push to main branch) to:
  - Build and push the new image to github packages, docker hub (This needs to change to Callibrity's docker hub) and AWS ECR
  - Deploy the image from ECR to AWS ECS

## Terraform
- There are three terraform folders, for different infrastructure requirements.
1) awsstate- This creates s3 buckets to store remote states for the resources created in the other two folders. This needs to run first before the github workflows automatically run the other two folders.
2) awsbase- This creates the base resources needed to run the tasks and services, such as VPC, subnets, clusters etc. This is automatically executed by the github workflows.
3) awsecstaskservice - This creates the task and service to deploy our image from ECR to ECS. This is automatically executed by the github workflows.
