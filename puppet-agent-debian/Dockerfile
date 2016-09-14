FROM debian:8
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_AGENT_VERSION="1.6.2" DEBIAN_CODENAME="jessie"

LABEL org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.name="Puppet Agent (Debian)" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version=$PUPPET_AGENT_VERSION \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.vcs-ref="791b5505348e901a21b2ca2700068e2743019848" \
      org.label-schema.build-date="2016-09-14T13:37:00Z" \
      org.label-schema.schema-version="1.0" \
      com.puppet.dockerfile="/Dockerfile"

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
