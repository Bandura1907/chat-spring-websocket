FROM maven:3.8.5-openjdk-17 AS build
RUN mkdir -p workspace
WORKDIR workspace
COPY ./pom.xml /workspace
COPY ./src /workspace/src
RUN mvn -f pom.xml clean install -DskipTests
#
FROM openjdk:17
COPY --from=build /workspace/target/*.jar chat.jar
EXPOSE 4200
ENTRYPOINT ["java","-jar","chat.jar"]