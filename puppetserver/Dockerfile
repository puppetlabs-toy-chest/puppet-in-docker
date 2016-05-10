FROM ubuntu:14.04
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

ENV PUPPET_SERVER_VERSION="2.3.2" PUPPETSERVER_JAVA_ARGS="-Xms256m -Xmx256m" PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

LABEL com.puppet.version=$PUPPET_SERVER_VERSION com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="80a406f29bfcb95d0b08bdf868d048ab1cdadf6a" com.puppet.build-time="2016-05-09T16:43:46Z" com.puppet.dockerfile="/Dockerfile"

RUN apt-get update && \
    apt-get install -y wget=1.15-1ubuntu1 && \
    wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb && \
    dpkg -i puppetlabs-release-pc1-trusty.deb && \
    apt-get update && \
    apt-get install --no-install-recommends -y puppetserver="$PUPPET_SERVER_VERSION"-1puppetlabs1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY puppetserver /etc/default/puppetserver
COPY logback.xml /etc/puppetlabs/puppetserver/
COPY request-logging.xml /etc/puppetlabs/puppetserver/

RUN puppet config set autosign true --section master

COPY Dockerfile /

VOLUME /etc/puppetlabs/code/

EXPOSE 8140

ENTRYPOINT ["/opt/puppetlabs/bin/puppetserver"]
CMD ["foreground" ]
