FROM nginx:alpine
LABEL maintainer="Binarick <e89139139835@gmail.com>"
RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash
COPY ./docker/production/default.conf ./etc/nginx/conf.d/default.cof
WORKDIR /app
COPY ./public ./public
