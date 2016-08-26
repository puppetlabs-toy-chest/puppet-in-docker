FROM puppet/puppet-agent-ubuntu:1.6.1
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_INVENTORY_VERSION="0.2.0"

LABEL com.puppet.version=$PUPPET_INVENTORY_VERSION com.puppet.git.sha="d5e378b4ac1775b7a8125208a65e0e5ef2823411" com.puppet.buildtime="2016-08-24T09:04:32Z"

RUN /opt/puppetlabs/bin/puppet module install puppetlabs-inventory --version "$PUPPET_INVENTORY_VERSION"

ENTRYPOINT ["/opt/puppetlabs/bin/puppet", "inventory"]

COPY Dockerfile /
