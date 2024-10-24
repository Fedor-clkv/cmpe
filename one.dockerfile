FROM ubuntu:22.04 AS builder
LABEL version="3" maintainer="Fedor Chulkov"
RUN apt update -y && apt upgrade -y && apt install openjdk-17-jdk -y && apt install maven -y && apt install git -y
WORKDIR /opt
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /opt/boxfuse-sample-java-war-hello
RUN rm pom.xml
ADD pom.xml /opt/boxfuse-sample-java-war-hello/
RUN mvn package
FROM tomcat:9.0-jdk17
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
#RUN chmod +x /usr/local/tomcat/bin/catalina.sh
#RUN apt update -y && apt upgrade -y && apt install wget -y && apt install openjdk-17-jdk -y
#ENV JAVA_HOME /usr/lib/jvm/default-java
#ENV JRE_HOME $JAVA_HOME
#RUN mkdir /usr/local/tomcat
#WORKDIR /tmp
#UN wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.20/bin/apache-tomcat-10.0.20.tar.gz && tar xvfz apache-tomcat-10.0.20.tar.gz && cp -Rv /tmp/apache-tomcat-10.0.20/* /usr/local/tomcat/
COPY --from=builder /opt/boxfuse-sample-java-war-hello/target/hello-1.0.war /usr/local/tomcat/webapps
EXPOSE 8080
#ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh"]
#CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

