FROM ubuntu:14.04
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPETDB_VERSION="4.0.2" PUPPETDB_USER=puppet PUPPETDB_PASSWORD=puppetdb PUPPETDB_JAVA_ARGS="-Djava.net.preferIPv4Stack=true -Xms256m -Xmx256m" PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

LABEL com.puppet.version=$PUPPETDB_VERSION com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="30bdf611465e2296ec01facf7dc1ee73efd85af7" com.puppet.build-time="2016-05-09T14:27:10Z" com.puppet.dockerfile="/Dockerfile"

RUN apt-get update && \
    apt-get install -y wget=1.15-1ubuntu1 && \
    wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb && \
    dpkg -i puppetlabs-release-pc1-trusty.deb && \
    apt-get update && \
    apt-get install --no-install-recommends -y puppetdb="$PUPPETDB_VERSION"-1puppetlabs1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY Dockerfile /

COPY puppetdb /etc/default/
COPY logging /etc/puppetlabs/puppetdb/logging

RUN rm -fr /etc/puppetlabs/puppetdb/conf.d
COPY conf.d /etc/puppetlabs/puppetdb/conf.d

EXPOSE 8080 8081

ENTRYPOINT ["/opt/puppetlabs/server/bin/puppetdb"]
CMD ["foreground" ]
