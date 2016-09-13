FROM puppet/puppet-agent-ubuntu:1.6.2
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_INVENTORY_VERSION="0.3.0"

LABEL com.puppet.version=$PUPPET_INVENTORY_VERSION com.puppet.git.sha="b465594f8f1f326d98a215d200d1b53d33c44275" com.puppet.buildtime="2016-09-13T08:30:20Z"

RUN /opt/puppetlabs/bin/puppet module install puppetlabs-inventory --version "$PUPPET_INVENTORY_VERSION"

VOLUME /opt/puppetlabs /etc/puppetlabs

ENTRYPOINT ["/opt/puppetlabs/bin/puppet", "inventory"]

COPY Dockerfile /
