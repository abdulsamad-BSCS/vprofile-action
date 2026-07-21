FROM maven:3.9.9-eclipse-temurin-17 AS BUILD_IMAGE
COPY ./ vprofile-project
RUN cd vprofile-project && mvn install

FROM tomcat:9.0-jdk17-temurin
LABEL "Project"="Vprofile"
LABEL "Author"="Imran"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]