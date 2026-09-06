ARG JAVA_VERSION=21

# BUILD
FROM maven:3.9-eclipse-temurin-${JAVA_VERSION} AS build

WORKDIR /workspace

COPY pom.xml .

RUN mvn -B -ntp dependency:go-offline

COPY src ./src

RUN mvn -B -ntp clean package -DskipTests

# RUNTIME
FROM eclipse-temurin:${JAVA_VERSION}-jre-jammy AS runtime

RUN groupadd --system spring \
    && useradd \
    --system \
    --gid spring \
    --create-home \
    spring

WORKDIR /app

COPY --from=build --chown=spring:spring /workspace/target/*.jar app.jar

USER spring

EXPOSE 8080

ENV JAVA_OPTS="\
-XX:+UserContainerSupport \
-XX:MaxRAMPercentage=75.0 \
-XX:+ExitOnOutOfMemoryError"

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
