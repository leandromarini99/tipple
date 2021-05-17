FROM openjdk:11
WORKDIR /tipple
VOLUME ["/tipple"]
COPY target/tipple-service.jar tipple-service.jar
COPY scripts/start.sh start.sh
COPY scripts/wait-for-it.sh wait-for-it.sh
RUN sh -c 'touch tipple-service.jar'
ENTRYPOINT ["./start.sh"]
