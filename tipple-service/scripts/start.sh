#! /bin/bash
./wait-for-it.sh tipple-mongo:27017 -t 30
java -Dspring.data.mongodb.uri=mongodb://tipple-mongo:27017/tipple -Djava.security.egd=file:/dev/./urandom -jar tipple-service.jar
