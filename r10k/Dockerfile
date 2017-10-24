FROM puppet/puppet-agent-ubuntu:5.3.2
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV R10K_VERSION="2.5.5"

LABEL org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.name="r10k" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version=$R10K_VERSION \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.vcs-ref="897dbb17ad2194153ef09e5e9b684f17ceb019a2" \
      org.label-schema.build-date="2017-10-24T11:26:06Z" \
      org.label-schema.schema-version="1.0" \
      com.puppet.dockerfile="/Dockerfile"

RUN apt-get update && \
    apt-get install --no-install-recommends -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN /opt/puppetlabs/puppet/bin/gem install r10k:"$R10K_VERSION"

ENTRYPOINT ["/opt/puppetlabs/puppet/bin/r10k"]
CMD ["help"]

COPY Dockerfile /
