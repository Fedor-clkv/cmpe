FROM tomcat:9.0.96-jre8-temurin-noble

RUN cp /tmp/flyseum.war /usr/local/tomcat/webapps
