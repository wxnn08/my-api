FROM clojure:openjdk-8-lein-slim-buster AS build-jar
WORKDIR /usr/src
COPY . .
RUN lein uberjar && ls -la /usr/src/target

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build-jar /usr/src/target/my-api-0.0.1-SNAPSHOT-standalone.jar /app/my-api.jar
EXPOSE 8080
CMD ["java", "-jar", "my-api.jar"]
