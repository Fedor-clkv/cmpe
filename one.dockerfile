FROM ubuntu:22.04 AS builder
LABEL version="3" maintainer="Fedor Chulkov"
RUN apt update -y && apt upgrade -y && apt install default-jdk -y && apt install maven -y && apt install git -y
WORKDIR /opt
RUN git clone https://github.com/imgios/flyseum
WORKDIR /opt/flyseum/
RUN mvn package
FROM ubuntu:22.04
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir /usr/local/tomcat
RUN apt update -y && apt install default-jdk -y && apt install default-jre -y apt install wget -y
WORKDIR /tmp
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.96/bin/apache-tomcat-9.0.96.tar.gz
RUN tar xvfz apache-tomcat-9.0.96.tar.gz
RUN cp -Rv /tmp/apache-tomcat-9.0.96/* /usr/local/tomcat/
COPY --from=builder /opt/flyseum/target/flyseum.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

