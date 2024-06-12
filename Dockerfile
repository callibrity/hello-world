FROM tomcat:latest

# Remove default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy WAR file to Tomcat webapps directory
COPY target/hello-world-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 9090

CMD ["catalina.sh", "run"]