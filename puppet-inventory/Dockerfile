FROM puppet/puppet-agent-ubuntu:1.6.0
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_INVENTORY_VERSION="0.2.0"

LABEL com.puppet.version=$PUPPET_INVENTORY_VERSION com.puppet.git.sha="b441445ca4c565eee2536bd01260c498012d5c5b" com.puppet.buildtime="2016-08-12T07:55:18Z"

RUN /opt/puppetlabs/bin/puppet module install puppetlabs-inventory --version "$PUPPET_INVENTORY_VERSION"

ENTRYPOINT ["/opt/puppetlabs/bin/puppet", "inventory"]

COPY Dockerfile /
