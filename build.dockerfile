FROM eclipse-temurin:11-jdk-alpine

RUN apk add --no-cache bash procps curl tar openssh-client

# common for all images
LABEL org.opencontainers.image.title="Apache Maven"
LABEL org.opencontainers.image.source=https://github.com/carlossg/docker-maven
LABEL org.opencontainers.image.url=https://github.com/carlossg/docker-maven
LABEL org.opencontainers.image.description="Apache Maven is a software project management and comprehension tool. Based on the concept of a project object model (POM), Maven can manage a project's build, reporting and documentation from a central piece of information."

ENV MAVEN_HOME=/usr/share/maven

COPY --from=maven:3.9.9-eclipse-temurin-17 ${MAVEN_HOME} ${MAVEN_HOME}
COPY --from=maven:3.9.9-eclipse-temurin-17 /usr/local/bin/mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY --from=maven:3.9.9-eclipse-temurin-17 /usr/share/maven/ref/settings-docker.xml /usr/share/maven/ref/settings-docker.xml

RUN ln -s ${MAVEN_HOME}/bin/mvn /usr/bin/mvn

ARG MAVEN_VERSION=3.9.9
ARG USER_HOME_DIR="/root"
ENV MAVEN_CONFIG="$USER_HOME_DIR/.m2"

WORKDIR /opt
RUN apt update -y 
RUN apt install git -y 
RUN git clone https://github.com/imgios/flyseum.git
WORKDIR /opt/flyseum
RUN mvn package
WORKDIR /opt/flyseum/target
RUN cp flyseum.war /tmp

ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
CMD ["mvn"]