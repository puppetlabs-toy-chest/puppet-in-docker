FROM debian:8
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_AGENT_VERSION="1.5.1" DEBIAN_CODENAME="jessie"

LABEL com.puppet.version=$PUPPET_AGENT_VERSION com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="1871d10bbd0d04aea8dfff238e98f3f8a0dcdcb0" com.puppet.buildtime="2016-06-13T09:11:07Z" com.puppet.dockerfile="/Dockerfile"

RUN apt-get update && \
    apt-get install -y wget=1.16-1 && \
    wget https://apt.puppetlabs.com/puppetlabs-release-pc1-"$DEBIAN_CODENAME".deb && \
    dpkg -i puppetlabs-release-pc1-"$DEBIAN_CODENAME".deb && \
    rm puppetlabs-release-pc1-"$DEBIAN_CODENAME".deb && \
    apt-get update && \
    apt-get install --no-install-recommends -y puppet-agent="$PUPPET_AGENT_VERSION"-1"$DEBIAN_CODENAME" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

ENTRYPOINT ["/opt/puppetlabs/bin/puppet"]
CMD ["agent", "--verbose", "--onetime", "--no-daemonize", "--summarize" ]

COPY Dockerfile /
