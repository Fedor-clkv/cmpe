FROM maven:3.9.6-eclipse-temurin-17 AS builder

RUN mkdir -p /opt/app/
WORKDIR /opt/app/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /opt/app/boxfuse-sample-java-war-hello/

RUN rm pom.xml 
COPY pom.xml /opt/app/boxfuse-sample-java-war-hello/
RUN mvn package

FROM tomcat:9.0-jdk17
COPY --from=builder /opt/app/boxfuse-sample-java-war-hello/target/hello-1.0.war /usr/local/tomcat/webapps/