FROM python:2.7-alpine

ENV PUPPET_BOARD_VERSION="0.3.0" \
    GUNICORN_VERSION="19.7.1" \
    PUPPETBOARD_PORT="8000" \
    PUPPETBOARD_SETTINGS="docker_settings.py"

LABEL org.label-schema.maintainer="Puppet Release Team <release@puppet.com>" \
      org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.name="Puppetboard" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version=$PUPPET_BOARD_VERSION \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.vcs-ref="b42e1266fd336189870aaadb90a5c9db9faa28d2" \
      org.label-schema.build-date="2018-05-21T17:57:42Z" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.dockerfile="/Dockerfile"

RUN pip install puppetboard=="$PUPPET_BOARD_VERSION" gunicorn=="$GUNICORN_VERSION"

EXPOSE $PUPPETBOARD_PORT

WORKDIR /var/www/puppetboard

CMD gunicorn -b 0.0.0.0:${PUPPETBOARD_PORT} --access-logfile=/dev/stdout puppetboard.app:app
# Health check
HEALTHCHECK --interval=10s --timeout=10s --retries=90 CMD \
  curl --fail -X GET localhost:8000\
  |  grep -q 'Live from PuppetDB' \
  || exit 1

COPY Dockerfile /
