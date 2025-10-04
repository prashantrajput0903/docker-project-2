# -----------------------
# Stage 1: Build the project
# -----------------------
FROM eclipse-temurin:17-jdk-alpine AS build

# Set working directory
WORKDIR /usr/src/app

# Copy Maven files first for caching
COPY pom.xml .
COPY src ./src

# Build the project
RUN ./mvnw clean package -DskipTests

# -----------------------
# Stage 2: Create runtime image
# -----------------------
FROM eclipse-temurin:17-jdk-alpine

# Set working directory in the runtime image
ENV APP_HOME=/usr/src/app
WORKDIR $APP_HOME

# Expose port
EXPOSE 8080

# Copy the JAR from the build stage
COPY --from=build /usr/src/app/target/*.jar app.jar

# Run the application
CMD ["java", "-jar", "app.jar"]
