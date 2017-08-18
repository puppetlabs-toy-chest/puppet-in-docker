FROM puppet/puppet-agent-ubuntu:5.1.0
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_INVENTORY_VERSION="0.4.0"

LABEL org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.name="Puppet Inventory" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version=$PUPPET_INVENTORY_VERSION \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.vcs-ref="beb0c7f097bfdd92f79a943c06a8020576b021f9" \
      org.label-schema.build-date="2017-08-18T06:59:21Z" \
      org.label-schema.schema-version="1.0" \
      com.puppet.dockerfile="/Dockerfile"

RUN /opt/puppetlabs/bin/puppet module install puppetlabs-inventory --version "$PUPPET_INVENTORY_VERSION"

VOLUME /opt/puppetlabs /etc/puppetlabs

ENTRYPOINT ["/opt/puppetlabs/bin/puppet", "inventory"]

COPY Dockerfile /
