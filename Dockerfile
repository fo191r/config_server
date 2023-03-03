FROM gradle as builder
WORKDIR /home/gradle

COPY build.gradle settings.gradle ./
COPY src ./src
RUN gradle clean build bootJar -x test

FROM eclipse-temurin:19-jre-jammy
WORKDIR /home/gradle
EXPOSE 8888

RUN mkdir "/app"

COPY --from=builder /home/gradle/build/libs/config_server-1.0.0.jar /home/gradle/app.jar
ENTRYPOINT ["java","-jar","/home/gradle/app.jar"]