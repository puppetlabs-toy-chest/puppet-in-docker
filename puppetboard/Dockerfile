FROM alpine:3.3
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_BOARD_VERSION="0.1.3"

LABEL com.puppet.version=$PUPPET_BOARD_VERSION com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="80a406f29bfcb95d0b08bdf868d048ab1cdadf6a" com.puppet.buildtime="2016-05-09T16:43:46Z" com.puppet.dockerfile="/Dockerfile"

RUN apk add --no-cache --update py-pip && \
    rm -rf /var/cache/apk/*

RUN pip install puppetboard=="$PUPPET_BOARD_VERSION" gunicorn

COPY wsgi.py /var/www/puppetboard/
COPY settings.py /var/www/puppetboard/

EXPOSE 8000

WORKDIR /var/www/puppetboard

CMD ["/usr/bin/gunicorn", "-b", "0.0.0.0:8000", "wsgi:application"]

COPY Dockerfile /
