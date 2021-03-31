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
#Install Open JDK 9
RUN apt-get update \
    && apt-get -y -o Dpkg::Options::="--force-overwrite" install openjdk-9-jdk \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-9-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

COPY --from=build /home/app/target/s1-movie-catalog-service-0.0.1-SNAPSHOT.jar /usr/local/lib/tsrana.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","/usr/local/lib/tsrana.jar"]


#FROM openjdk:8
#ADD target/s1-movie-catalog-service-0.0.1-SNAPSHOT.jar s1-movie-catalog-service-0.0.1-SNAPSHOT.jar
#EXPOSE 8081
#ENTRYPOINT ["java", "-jar", "s1-movie-catalog-service-0.0.1-SNAPSHOT.jar"]
