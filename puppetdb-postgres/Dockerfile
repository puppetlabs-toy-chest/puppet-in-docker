FROM postgres:9.6.3
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.name="PostgreSQL instance for PuppetDB" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version="9.6.3" \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.vcs-ref="897dbb17ad2194153ef09e5e9b684f17ceb019a2" \
      org.label-schema.build-date="2017-10-24T11:26:06Z" \
      org.label-schema.schema-version="1.0" \
      com.puppet.dockerfile="/Dockerfile"

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

COPY Dockerfile /
