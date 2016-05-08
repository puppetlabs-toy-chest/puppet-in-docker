FROM alpine:3.3
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_VERSION="4.4.2" FACTER_VERSION="2.4.6"

LABEL com.puppet.version=$PUPPET_VERSION com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="30bdf611465e2296ec01facf7dc1ee73efd85af7" com.puppet.build-time="2016-05-09T14:27:10Z" com.puppet.dockerfile="/Dockerfile"

RUN apk add --update ruby ruby-rdoc ruby-irb ca-certificates && \
    echo http://dl-4.alpinelinux.org/alpine/edge/testing/ >> /etc/apk/repositories && \
    apk add --update shadow && \
    rm -rf /var/cache/apk/* && \
    gem install puppet:"$PUPPET_VERSION" facter:"$FACTER_VERSION" && \
    /usr/bin/puppet module install puppetlabs-apk

# Workaround for https://tickets.puppetlabs.com/browse/FACT-1351
RUN rm /usr/lib/ruby/gems/2.2.0/gems/facter-"$FACTER_VERSION"/lib/facter/blockdevices.rb

ENTRYPOINT ["/usr/bin/puppet"]
CMD ["agent", "--verbose", "--onetime", "--no-daemonize", "--summarize" ]
