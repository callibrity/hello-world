### Maven Build
FROM maven:3-openjdk-17 as builder
RUN mkdir -p /build
COPY . /build
WORKDIR /build
RUN mvn clean compile package


### Build docker image
FROM tomcat:latest
# Remove default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=builder /build/target /tom/target
WORKDIR /tom/target
RUN cp *.war /usr/local/tomcat/webapps/
EXPOSE 9090
CMD ["catalina.sh", "run"]