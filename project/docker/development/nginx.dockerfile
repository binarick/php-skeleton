FROM nginx:alpine

LABEL maintainer="Binarick <e89139139835@gmail.com>"

COPY default.conf /etc/nginx/conf.d/default.conf

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash

WORKDIR /app
