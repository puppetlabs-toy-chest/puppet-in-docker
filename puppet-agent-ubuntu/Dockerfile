FROM ubuntu:16.04
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_AGENT_VERSION="1.5.0" UBUNTU_CODENAME="xenial"

LABEL com.puppet.version=$PUPPET_AGENT_VERSION com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="97475979ffe252d33a9df67524b5aa313022cb05" com.puppet.buildtime="2016-05-20T10:01:19Z" com.puppet.dockerfile="/Dockerfile"

RUN apt-get update && \
    apt-get install -y wget=1.17.1-1ubuntu1 && \
    wget https://apt.puppetlabs.com/puppetlabs-release-pc1-"$UBUNTU_CODENAME".deb && \
    dpkg -i puppetlabs-release-pc1-"$UBUNTU_CODENAME".deb && \
    apt-get update && \
    apt-get install --no-install-recommends -y puppet-agent="$PUPPET_AGENT_VERSION"-1"$UBUNTU_CODENAME" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

ENTRYPOINT ["/opt/puppetlabs/bin/puppet"]
CMD ["agent", "--verbose", "--onetime", "--no-daemonize", "--summarize" ]

COPY Dockerfile /
