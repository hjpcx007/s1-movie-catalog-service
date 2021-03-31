#
# Build stage
#
FROM maven:3.6.3-jdk-8 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
#FROM xqdocker/ubuntu-openjdk:9
#COPY --from=build /home/app/target/s1-movie-catalog-service-0.0.1-SNAPSHOT.jar /usr/local/lib/tsrana.jar
#EXPOSE 8081
#ENTRYPOINT ["java","-jar","/usr/local/lib/tsrana.jar"]



FROM ubuntu:20.04

RUN apt-get update && \
	apt-get install -y sudo && \
	apt-get install -y openjdk-8-jdk && \
	apt-get install -y ant && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;
	
# Fix certificate issues, found as of 
# https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302
RUN apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME
ENV PATH $JAVA_HOME/bin:$PATH

COPY --from=build /home/app/target/s1-movie-catalog-service-0.0.1-SNAPSHOT.jar /usr/local/lib/tsrana.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","/usr/local/lib/tsrana.jar"]

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
USER docker
CMD /bin/bash

#FROM openjdk:8
#ADD target/s1-movie-catalog-service-0.0.1-SNAPSHOT.jar s1-movie-catalog-service-0.0.1-SNAPSHOT.jar
#EXPOSE 8081
#ENTRYPOINT ["java", "-jar", "s1-movie-catalog-service-0.0.1-SNAPSHOT.jar"]
