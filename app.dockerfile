FROM tomcat:9.0.96-jre8-temurin-noble

RUN cp /tmp/hello-1.0.war /usr/local/tomcat/webapps
