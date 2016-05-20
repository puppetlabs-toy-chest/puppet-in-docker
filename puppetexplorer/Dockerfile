FROM alpine:3.3
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_EXPLORER_VERSION="2.0.0"

LABEL com.puppet.version=$PUPPET_EXPLORER_VERSION com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="97475979ffe252d33a9df67524b5aa313022cb05" com.puppet.buildtime="2016-05-20T10:01:19Z" com.puppet.dockerfile="/Dockerfile"

RUN apk add --no-cache --update ca-certificates && \
    rm -rf /var/cache/apk/*

RUN wget "https://caddyserver.com/download/build?os=linux&arch=amd64&features=cors,jsonp,prometheus,realip" -O - | tar -xz --no-same-owner -C /usr/bin/ caddy

RUN wget https://github.com/spotify/puppetexplorer/releases/download/"$PUPPET_EXPLORER_VERSION"/puppetexplorer-"$PUPPET_EXPLORER_VERSION".tar.gz -O - | tar -xz && \
    ln -s puppetexplorer-"$PUPPET_EXPLORER_VERSION" /puppetexplorer

# This patch fixes https://github.com/spotify/puppetexplorer/issues/56 until a new release of puppetexplorer is made
RUN sed -i -e 's/puppetlabs\.puppetdb\.query\.population/puppetlabs\.puppetdb\.population/g' -e 's/type=default,//g' /puppetexplorer/app.js

COPY Caddyfile /etc/caddy/Caddyfile
COPY config.js /puppetexplorer

EXPOSE 80

WORKDIR /etc/caddy

CMD ["/usr/bin/caddy"]

COPY Dockerfile /
