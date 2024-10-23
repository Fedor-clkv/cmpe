FROM FROM tomcat:9.0-jdk17

RUN cp /tmp/hello-1.0.war /usr/local/tomcat/webapps
