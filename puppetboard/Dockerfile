FROM alpine:3.4
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_BOARD_VERSION="0.2.2" \
    GUNICORN_VERSION="19.7.1" \
    PUPPETBOARD_PORT="8000"

LABEL org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.name="Puppetboard" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version=$PUPPET_BOARD_VERSION \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.vcs-ref="23e643fb61f462738e63b3f6700744a2455ca3a6" \
      org.label-schema.build-date="2017-06-30T08:56:49Z" \
      org.label-schema.schema-version="1.0" \
      com.puppet.dockerfile="/Dockerfile"

RUN apk add --no-cache --update curl py-pip && \
    rm -rf /var/cache/apk/*

RUN pip install puppetboard=="$PUPPET_BOARD_VERSION" gunicorn=="$GUNICORN_VERSION"

COPY wsgi.py settings.py /var/www/puppetboard/

EXPOSE $PUPPETBOARD_PORT

WORKDIR /var/www/puppetboard

CMD /usr/bin/gunicorn -b 0.0.0.0:${PUPPETBOARD_PORT} --access-logfile=/dev/stdout wsgi:application

# Health check
HEALTHCHECK --interval=10s --timeout=10s --retries=90 CMD \
  curl --fail -X GET localhost:${PUPPETBOARD_PORT} \
  |  grep -q 'Live from PuppetDB' \
  || exit 1

COPY Dockerfile /
