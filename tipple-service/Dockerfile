FROM openjdk:11
#ARG JAR_FILE=target/*.jar
ADD ./target/tipple-service-0.0.1-SNAPSHOT.jar /usr/tipple/tipple-service.jar
WORKDIR /usr/tipple
ENTRYPOINT ["java","-Dspring.data.mongodb.uri=mongodb://mongo:27017/tipple","-Djava.security.egd=file:/dev/./urandom","-jar", "tipple-service.jar"]