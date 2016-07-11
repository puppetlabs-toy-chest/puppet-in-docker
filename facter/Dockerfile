FROM puppet/puppet-agent-ubuntu:1.5.2
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL com.puppet.version=$PUPPET_AGENT_VERSION com.puppet.git.sha="4afbb13eea650fce8301b2d181687f806700fc2f" com.puppet.buildtime="2016-06-15T09:06:04Z"

ENTRYPOINT ["facter"]
CMD [""]

COPY Dockerfile /
