FROM alpine:3.4
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_VERSION="4.6.1" FACTER_VERSION="2.4.6"

LABEL com.puppet.version=$PUPPET_VERSION com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="d5e378b4ac1775b7a8125208a65e0e5ef2823411" com.puppet.buildtime="2016-08-24T08:00:12Z" com.puppet.dockerfile="/Dockerfile"

RUN apk add --update \
      ca-certificates \
      pciutils \
      ruby \
      ruby-irb \
      ruby-rdoc \
      && \
    echo http://dl-4.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories && \
    apk add --update shadow && \
    rm -rf /var/cache/apk/* && \
    gem install puppet:"$PUPPET_VERSION" facter:"$FACTER_VERSION" && \
    /usr/bin/puppet module install puppetlabs-apk

# Workaround for https://tickets.puppetlabs.com/browse/FACT-1351
RUN rm /usr/lib/ruby/gems/2.3.0/gems/facter-"$FACTER_VERSION"/lib/facter/blockdevices.rb

ENTRYPOINT ["/usr/bin/puppet"]
CMD ["agent", "--verbose", "--onetime", "--no-daemonize", "--summarize" ]

COPY Dockerfile /
