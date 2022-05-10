FROM golang:alpine3.15 as build-stage

RUN apk --update --no-cache add \
    git

RUN git clone -b 1.14 --depth 1 --single-branch https://github.com/tianon/gosu /src

RUN cd /src && go build -o bin/gosu

FROM alpine:3.15

LABEL maintainer="VergilGao"
LABEL build_from="https://github.com/tianon/gosu"
LABEL org.opencontainers.image.source="https://github.com/VergilGao/docker-alpine-baseimage"

COPY --from=build-stage /src/bin/ /bin

RUN apk --update  --no-cache add \
    ca-certificates \
    coreutils \
    shadow \
    tzdata