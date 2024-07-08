ARG BUILD_PATH=build/libs/
ARG GRADLE_VERSION=8.8.0

FROM gradle:${GRADLE_VERSION}-jdk21-alpine

WORKDIR /ayni

COPY . /ayni
EXPOSE 8080

RUN chmod +x start.sh && ./gradlew dependencies
CMD ["sh", "start.sh"]