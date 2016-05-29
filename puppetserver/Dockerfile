FROM puppet/puppetserver-standalone:2.4.0
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPETDB_TERMINUS_VERSION="4.1.0"

LABEL com.puppet.version=$PUPPET_SERVER_VERSION com.puppet.git.sha="ca4b5726dd0e244b04ed7f84d6568f79943c91ce" com.puppet.buildtime="2016-05-29T08:18:48Z"

RUN apt-get update && \
    apt-get install --no-install-recommends -y puppetdb-termini="$PUPPETDB_TERMINUS_VERSION"-1puppetlabs1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN puppet config set storeconfigs_backend puppetdb --section main && \
    puppet config set storeconfigs true --section main && \
    puppet config set reports puppetdb --section main

COPY puppetdb.conf /etc/puppetlabs/puppet/

COPY Dockerfile /
