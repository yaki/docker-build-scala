FROM openjdk:8-jdk-alpine3.7

ENV sbt_version 1.1.0
ENV sbt_home /usr/local/sbt
ENV PATH ${PATH}:${sbt_home}/bin

RUN apk --no-cache --update add curl \
    && apk add docker \
    && apk add gcc \
    && apk add git \
    && apk add musl-dev \
    && apk add sudo \
    && apk add bash \
    && apk add wget \
    && apk add shadow \
    && apk add mysql-client \
    && apk add openssh

# SBTインストール
RUN mkdir -p "$sbt_home" && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk && apk add glibc-2.28-r0.apk && rm glibc-2.28-r0.apk && \
    wget -qO - --no-check-certificate "https://github.com/sbt/sbt/releases/download/v$sbt_version/sbt-$sbt_version.tgz" | tar xz -C $sbt_home --strip-components=1 && \
    apk del wget && \
    sbt sbtVersion

# デフォルトをbashに変更
RUN chsh -s /bin/bash
