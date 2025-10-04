FROM eclipse-temurin:17-jdk-alpine
WORKDIR $APP_HOME
EXPOSE 8080


RUN ls 

ENV APP_HOME /usr/src/app

COPY app/*.jar $APP_HOME/app.jar



CMD ["java", "-jar", "app.jar"]
