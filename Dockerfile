FROM tomcat:latest

# Remove default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

RUN cd lib

RUN ls
# Copy WAR file to Tomcat webapps directory
COPY hello-world/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 9090

CMD ["catalina.sh", "run"]