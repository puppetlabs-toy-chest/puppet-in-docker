FROM puppet/puppet-agent-ubuntu:1.6.2
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_INVENTORY_VERSION="0.3.0"

LABEL org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.name="Puppet Inventory" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version=$PUPPET_INVENTORY_VERSION \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.vcs-ref="791b5505348e901a21b2ca2700068e2743019848" \
      org.label-schema.build-date="2016-09-14T13:37:00Z" \
      org.label-schema.schema-version="1.0" \
      com.puppet.dockerfile="/Dockerfile"

RUN /opt/puppetlabs/bin/puppet module install puppetlabs-inventory --version "$PUPPET_INVENTORY_VERSION"

VOLUME /opt/puppetlabs /etc/puppetlabs

ENTRYPOINT ["/opt/puppetlabs/bin/puppet", "inventory"]

COPY Dockerfile /
