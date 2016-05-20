FROM ubuntu:16.04
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPETDB_VERSION="4.1.0" PUPPET_AGENT_VERSION="1.5.0" UBUNTU_CODENAME="xenial" PUPPETDB_USER=puppetdb PUPPETDB_PASSWORD=puppetdb PUPPETDB_JAVA_ARGS="-Djava.net.preferIPv4Stack=true -Xms256m -Xmx256m" PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

LABEL com.puppet.version=$PUPPETDB_VERSION com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="97475979ffe252d33a9df67524b5aa313022cb05" com.puppet.buildtime="2016-05-20T10:01:19Z" com.puppet.dockerfile="/Dockerfile"

RUN apt-get update && \
    apt-get install -y wget=1.17.1-1ubuntu1 netcat=1.10-41 && \
    wget https://apt.puppetlabs.com/puppetlabs-release-pc1-"$UBUNTU_CODENAME".deb && \
    dpkg -i puppetlabs-release-pc1-"$UBUNTU_CODENAME".deb && \
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

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["foreground"]

COPY Dockerfile /
