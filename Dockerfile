FROM maven:3.8.4-openjdk-11-slim AS build

# Imposta la directory di lavoro
WORKDIR /app

# Copia i file del progetto
COPY pom.xml .
COPY src ./src

# Build dell'applicazione
RUN mvn clean package -DskipTests

# Stage 2: Setup Tomcat runtime
FROM tomcat:10-jdk11-openjdk-slim

# Rimuovere le applicazioni di default di Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia il file WAR generato nella cartella webapps di Tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Configura il database MySQL
ENV MYSQL_HOST=db
ENV MYSQL_PORT=3306
ENV MYSQL_DB=ttunisa
ENV MYSQL_USER=root
ENV MYSQL_PASSWORD=mysq

# Esponi la porta 8080
EXPOSE 8080

# Comando di avvio
CMD ["catalina.sh", "run"] 