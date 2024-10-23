FROM maven:3.9.6-eclipse-temurin-17

RUN mkdir -p /opt/app/
WORKDIR /opt/app/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /opt/app/boxfuse-sample-java-war-hello/
#RUN rm pom.xml
#COPY pom.xml /opt/app/boxfuse-sample-java-war-hello/
RUN mvn package
WORKDIR /opt/app/boxfuse-sample-java-war-hello/target/
RUN cp hello-1.0.war /tmp/