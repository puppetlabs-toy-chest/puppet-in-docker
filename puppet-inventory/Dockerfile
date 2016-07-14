FROM puppet/puppet-agent-ubuntu:1.5.2
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_INVENTORY_VERSION="0.1.0"

LABEL com.puppet.version=$PUPPET_INVENTORY_VERSION com.puppet.git.sha="929538bcaea885c12b7305e386206b6580873c42" com.puppet.buildtime="2016-07-14T11:25:10Z"

RUN /opt/puppetlabs/bin/puppet module install puppetlabs-inventory --version "$PUPPET_INVENTORY_VERSION"

ENTRYPOINT ["/opt/puppetlabs/bin/puppet", "inventory"]
CMD ["all"]

COPY Dockerfile /
