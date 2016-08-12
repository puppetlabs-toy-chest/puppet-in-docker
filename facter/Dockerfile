FROM puppet/puppet-agent-ubuntu:1.6.0
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL com.puppet.version=$PUPPET_AGENT_VERSION com.puppet.git.sha="b441445ca4c565eee2536bd01260c498012d5c5b" com.puppet.buildtime="2016-08-12T07:55:18Z"

ENTRYPOINT ["facter"]
CMD [""]

COPY Dockerfile /
