FROM alpine:3.4
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_BOARD_VERSION="0.1.3" GUNICORN_VERSION="19.6.0"

LABEL com.puppet.version=$PUPPET_BOARD_VERSION com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="ffeb9772ad67da19d12b69a898fd431c919188ed" com.puppet.buildtime="2016-08-12T08:14:20Z" com.puppet.dockerfile="/Dockerfile"

RUN apk add --no-cache --update py-pip && \
    rm -rf /var/cache/apk/*

RUN pip install puppetboard=="$PUPPET_BOARD_VERSION" gunicorn=="$GUNICORN_VERSION"

COPY wsgi.py /var/www/puppetboard/
COPY settings.py /var/www/puppetboard/

EXPOSE 8000

WORKDIR /var/www/puppetboard

CMD ["/usr/bin/gunicorn", "-b", "0.0.0.0:8000", "wsgi:application"]

COPY Dockerfile /
