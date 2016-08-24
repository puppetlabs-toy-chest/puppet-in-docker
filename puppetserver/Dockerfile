FROM puppet/puppetserver-standalone:2.5.0
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPETDB_TERMINUS_VERSION="4.2.0"

LABEL com.puppet.version=$PUPPET_SERVER_VERSION com.puppet.git.sha="ed2df19a136bb52ec6c4f08370a781d65733f62e" com.puppet.buildtime="2016-08-23T09:16:05Z"

RUN apt-get update && \
    apt-get install --no-install-recommends -y puppetdb-termini="$PUPPETDB_TERMINUS_VERSION"-1puppetlabs1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN puppet config set storeconfigs_backend puppetdb --section main && \
    puppet config set storeconfigs true --section main && \
    puppet config set reports puppetdb --section main

COPY puppetdb.conf /etc/puppetlabs/puppet/

COPY Dockerfile /
