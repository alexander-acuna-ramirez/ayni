ARG BUILD_PATH=build/libs/
ARG GRADLE_VERSION=8.8.0

FROM gradle:${GRADLE_VERSION}-jdk21-alpine

WORKDIR /ayni

COPY . /ayni
EXPOSE 8080


RUN ./gradlew dependencies 
ENTRYPOINT ["tail", "-f", "/dev/null"]
#ENTRYPOINT ["gradle", "bootRun", "-PskipDownload=true"]