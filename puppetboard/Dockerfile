FROM alpine:3.3
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_BOARD_VERSION="0.1.3" GUNICORN_VERSION="19.5.0"

LABEL com.puppet.version=$PUPPET_BOARD_VERSION com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="ca4b5726dd0e244b04ed7f84d6568f79943c91ce" com.puppet.buildtime="2016-05-29T08:18:48Z" com.puppet.dockerfile="/Dockerfile"

RUN apk add --no-cache --update py-pip && \
    rm -rf /var/cache/apk/*

RUN pip install puppetboard=="$PUPPET_BOARD_VERSION" gunicorn=="$GUNICORN_VERSION"

COPY wsgi.py /var/www/puppetboard/
COPY settings.py /var/www/puppetboard/

EXPOSE 8000

WORKDIR /var/www/puppetboard

CMD ["/usr/bin/gunicorn", "-b", "0.0.0.0:8000", "wsgi:application"]

COPY Dockerfile /
