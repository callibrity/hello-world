### Build docker image
FROM tomcat:latest
# Copy your WAR file to the webapps directory
RUN cp *.war /usr/local/tomcat/webapps/
# Expose the port that Tomcat is running on (default is 8080)
EXPOSE 8080
# Start Tomcat
CMD ["catalina.sh", "run"]