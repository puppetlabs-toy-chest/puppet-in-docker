FROM alpine:3.4
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_BOARD_VERSION="0.2.0" GUNICORN_VERSION="19.6.0"

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

RUN apk add --no-cache --update curl py-pip && \
    rm -rf /var/cache/apk/*

RUN pip install puppetboard=="$PUPPET_BOARD_VERSION" gunicorn=="$GUNICORN_VERSION"

COPY wsgi.py /var/www/puppetboard/
COPY settings.py /var/www/puppetboard/

EXPOSE 8000

WORKDIR /var/www/puppetboard

CMD ["/usr/bin/gunicorn", "-b", "0.0.0.0:8000", "wsgi:application"]

COPY Dockerfile /

# Health check
HEALTHCHECK --interval=10s --timeout=10s --retries=90 CMD \
  curl --fail -X GET localhost:${PUPPETBOARD_PORT} \
  |  grep -q 'Live from PuppetDB' \
  || exit 1
