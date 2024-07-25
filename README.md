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
  - Build and test the project
  - Build and push the new image to github packages, docker hub and AWS ECR (This needs to change to Callibrity's docker hub)
  - Deploy the image from ECR to AWS ECS
