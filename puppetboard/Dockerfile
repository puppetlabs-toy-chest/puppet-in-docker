FROM alpine:3.4
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_BOARD_VERSION="0.1.3" GUNICORN_VERSION="19.6.0"

LABEL com.puppet.version=$PUPPET_BOARD_VERSION com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="b441445ca4c565eee2536bd01260c498012d5c5b" com.puppet.buildtime="2016-08-12T07:55:18Z" com.puppet.dockerfile="/Dockerfile"

RUN apk add --no-cache --update py-pip && \
    rm -rf /var/cache/apk/*

RUN pip install puppetboard=="$PUPPET_BOARD_VERSION" gunicorn=="$GUNICORN_VERSION"

COPY wsgi.py /var/www/puppetboard/
COPY settings.py /var/www/puppetboard/

EXPOSE 8000

WORKDIR /var/www/puppetboard

CMD ["/usr/bin/gunicorn", "-b", "0.0.0.0:8000", "wsgi:application"]

COPY Dockerfile /
