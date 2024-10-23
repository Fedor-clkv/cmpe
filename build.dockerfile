FROM maven:3.9.6-eclipse-temurin-21-jammy

WORKDIR /opt
RUN git clone https://github.com/imgios/flyseum.git
WORKDIR /opt/flyseum
RUN ls -l /opt/flyseum
RUN mvn validate
RUN mvn package
WORKDIR /opt/flyseum/target
RUN cp flyseum.war /tmp