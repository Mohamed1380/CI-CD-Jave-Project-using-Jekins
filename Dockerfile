FROM maven:alpine as build
WORKDIR /app
COPY . .
RUN mvn install


# Using Multi stage build
FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/Myapp.jar .
EXPOSE 9090
CMD ["java", "-jar", "Myapp.jar"]


