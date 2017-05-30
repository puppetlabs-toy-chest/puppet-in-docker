FROM alpine:3.4
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_BOARD_VERSION="0.2.0" \
    GUNICORN_VERSION="19.6.0" \ 
    PUPPETBOARD_PORT="8000"

LABEL org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.name="Puppetboard" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version=$PUPPET_BOARD_VERSION \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.vcs-ref="a2b1fbbc73177ddc3def23d167f9beb9c3ef9f6c" \
      org.label-schema.build-date="2017-02-21T17:25:14Z" \
      org.label-schema.schema-version="1.0" \
      com.puppet.dockerfile="/Dockerfile"

RUN apk add --no-cache --update py-pip && \
    rm -rf /var/cache/apk/*

RUN pip install puppetboard=="$PUPPET_BOARD_VERSION" gunicorn=="$GUNICORN_VERSION"

COPY wsgi.py settings.py /var/www/puppetboard/

EXPOSE $PUPPETBOARD_PORT

WORKDIR /var/www/puppetboard

CMD /usr/bin/gunicorn -b 0.0.0.0:${PUPPETBOARD_PORT} wsgi:application

COPY Dockerfile /
