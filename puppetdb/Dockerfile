FROM ubuntu:16.04
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPETDB_VERSION="4.2.0" PUPPET_AGENT_VERSION="1.6.1" DUMB_INIT_VERSION="1.1.3" UBUNTU_CODENAME="xenial" PUPPETDB_USER=puppetdb PUPPETDB_PASSWORD=puppetdb PUPPETDB_JAVA_ARGS="-Djava.net.preferIPv4Stack=true -Xms256m -Xmx256m" PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

LABEL org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.name="PuppetDB" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version=$PUPPETDB_VERSION \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.vcs-ref="791b5505348e901a21b2ca2700068e2743019848" \
      org.label-schema.build-date="2016-09-14T13:37:00Z" \
      org.label-schema.schema-version="1.0" \
      com.puppet.dockerfile="/Dockerfile"

RUN apt-get update && \
    apt-get install -y wget=1.17.1-1ubuntu1 netcat=1.10-41 && \
    wget https://apt.puppetlabs.com/puppetlabs-release-pc1-"$UBUNTU_CODENAME".deb && \
    wget https://github.com/Yelp/dumb-init/releases/download/v"$DUMB_INIT_VERSION"/dumb-init_"$DUMB_INIT_VERSION"_amd64.deb && \
    dpkg -i puppetlabs-release-pc1-"$UBUNTU_CODENAME".deb && \
    dpkg -i dumb-init_"$DUMB_INIT_VERSION"_amd64.deb && \
    rm puppetlabs-release-pc1-"$UBUNTU_CODENAME".deb dumb-init_"$DUMB_INIT_VERSION"_amd64.deb && \
    apt-get update && \
    apt-get install --no-install-recommends -y puppet-agent="$PUPPET_AGENT_VERSION"-1"$UBUNTU_CODENAME" puppetdb="$PUPPETDB_VERSION"-1puppetlabs1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY puppetdb /etc/default/
COPY logging /etc/puppetlabs/puppetdb/logging

RUN rm -fr /etc/puppetlabs/puppetdb/conf.d
COPY conf.d /etc/puppetlabs/puppetdb/conf.d

COPY docker-entrypoint.sh /

EXPOSE 8080 8081

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["foreground"]

COPY Dockerfile /
