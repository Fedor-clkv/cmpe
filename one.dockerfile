FROM ubuntu:22.04 AS builder
LABEL version="3" maintainer="Fedor Chulkov"
RUN apt update -y && apt upgrade -y && apt install default-jdk -y && apt install maven -y && apt install git -y
WORKDIR /opt
RUN git clone https://github.com/imgios/flyseum
#WORKDIR /opt/boxfuse-sample-java-war-hello
WORKDIR /opt/flyseum/
#RUN rm pom.xml
#ADD pom.xml /opt/boxfuse-sample-java-war-hello/
RUN mvn package
FROM ubuntu:22.04
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir /usr/local/tomcat
#RUN groupadd tomcat
#RUN useradd -s /bin/false -g tomcat -d /usr/local/tomcat
RUN apt update -y && apt install default-jdk -y && apt install wget -y
WORKDIR /tmp
# Скачиваем архив и распаковываем его
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.96/bin/apache-tomcat-9.0.96.tar.gz
RUN tar xvfz tar xvfz apache-tomcat-9.0.96.tar.gz -C /usr/local/tomcat/
# Копируем распакованные файлы в рабочую директорию
#RUN cp -Rv /tmp/apache-tomcat-9.0.96-deployer/* /usr/local/tomcat/
#RUN chmod +x /usr/local/tomcat/bin/catalina.sh
#RUN apt update -y && apt upgrade -y && apt install wget -y && apt install openjdk-17-jdk -y
#ENV JAVA_HOME /usr/lib/jvm/default-java
#ENV JRE_HOME $JAVA_HOME
#RUN mkdir /usr/local/tomcat
#WORKDIR /tmp
#UN wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.20/bin/apache-tomcat-10.0.20.tar.gz && tar xvfz apache-tomcat-10.0.20.tar.gz && cp -Rv /tmp/apache-tomcat-10.0.20/* /usr/local/tomcat/
COPY --from=builder /opt/flyseum/target/flyseum.war /usr/local/tomcat/webapps
EXPOSE 8080
#ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh"]
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

