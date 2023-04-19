FROM openjdk:8 AS BUILD_IMAGE
RUN apt update && apt install maven -y
RUN git clone https://github.com/youngmind01/Docker-pipeline.git
RUN cd Docker-pipeline && mvn install

FROM tomcat:8-jre11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE Docker-pipeline/target/my-app-1.0.war /usr/local/tomcat/webapps/ROOT.jar

EXPOSE 8080
CMD ["catalina.sh", "run"]