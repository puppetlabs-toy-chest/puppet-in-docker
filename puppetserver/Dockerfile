FROM puppet/puppetserver-standalone:5.1.0
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPETDB_TERMINUS_VERSION="5.1.0"

LABEL org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.name="Puppet Server" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version=$PUPPET_SERVER_VERSION \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.vcs-ref="acabd767fa9587b6fcb918a63b1016bf01ae3535" \
      org.label-schema.build-date="2017-10-24T08:56:03Z" \
      org.label-schema.schema-version="1.0" \
      com.puppet.dockerfile="/Dockerfile"

RUN apt-get update && \
    apt-get install --no-install-recommends -y puppetdb-termini="$PUPPETDB_TERMINUS_VERSION"-1puppetlabs1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN puppet config set storeconfigs_backend puppetdb --section main && \
    puppet config set storeconfigs true --section main && \
    puppet config set reports puppetdb --section main

COPY puppetdb.conf /etc/puppetlabs/puppet/

COPY Dockerfile /
