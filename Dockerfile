# Use the official Maven image to build the project
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project (pom.xml and src folder)
COPY pom.xml .
COPY src ./src

# Package the application (generates a .war file)
RUN mvn clean test && mvn package -DskipTests

# Use the official Tomcat image to run the application
FROM tomcat:10.1.8-jdk17

# Set environment variables
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Copy the .war file from the build stage to Tomcat's webapps directory
COPY --from=build /app/target/*.war $CATALINA_HOME/webapps/ROOT.war

# Expose port 8080 for accessing the Tomcat server
EXPOSE 8080

# Start Tomcat when the container is run
CMD ["catalina.sh", "run"]