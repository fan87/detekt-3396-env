FROM adoptopenjdk/openjdk8

# Wrapper
ADD gradle/ /app/gradle/
COPY gradlew /app/

# src
ADD src/ /app/src/
ADD example/src/ /app/example/src/

# Root project
COPY build.gradle.kts /app/
COPY settings.gradle.kts /app/
COPY gradle.properties /app/

# example project
COPY example/build.gradle.kts /app/example/

# Test script
COPY produce.sh /app/

WORKDIR app/
ENTRYPOINT ./produce.sh