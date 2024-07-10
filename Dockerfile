FROM eclipse-temurin:18-jdk
WORKDIR /app
COPY target/hello-world-0.0.1-SNAPSHOT.jar /app/hello-world.jar
EXPOSE 8080
CMD ["java","-jar","/app/hello-world.jar"]