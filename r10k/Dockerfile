FROM puppet/puppet-agent-ubuntu:5.2.0
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV R10K_VERSION="2.5.5"

LABEL org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.name="r10k" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version=$R10K_VERSION \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.vcs-ref="acabd767fa9587b6fcb918a63b1016bf01ae3535" \
      org.label-schema.build-date="2017-10-24T08:56:22Z" \
      org.label-schema.schema-version="1.0" \
      com.puppet.dockerfile="/Dockerfile"

RUN /opt/puppetlabs/puppet/bin/gem install r10k:"$R10K_VERSION"

RUN ["apt-get","update"]
RUN ["apt-get","install","git","-y"]

ENTRYPOINT ["/opt/puppetlabs/puppet/bin/r10k"]
CMD ["help"]

COPY Dockerfile /
