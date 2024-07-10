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
