FROM maven:3.9.6-eclipse-temurin-21-jammy

RUN mkdir -p /opt/app
WORKDIR /opt/app
RUN git clone https://github.com/imgios/flyseum.git
WORKDIR /opt/app/flyseum
#RUN ls -l /opt/flyseum
#RUN mvn validate
RUN mvn package
#WORKDIR /opt/app/flyseum/target/
#RUN cp flyseum.war /tmp