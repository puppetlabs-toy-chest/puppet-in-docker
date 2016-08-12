FROM debian:8
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_AGENT_VERSION="1.6.0" DEBIAN_CODENAME="jessie"

LABEL com.puppet.version=$PUPPET_AGENT_VERSION com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="b441445ca4c565eee2536bd01260c498012d5c5b" com.puppet.buildtime="2016-08-12T07:55:18Z" com.puppet.dockerfile="/Dockerfile"

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
