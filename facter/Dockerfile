FROM puppet/puppet-agent-ubuntu:1.5.1
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL com.puppet.version=$PUPPET_AGENT_VERSION com.puppet.git.sha="e052bc472f14ab2d0c5a0a2fdb714abf11b232d5" com.puppet.buildtime="2016-06-02T07:55:49Z"

ENTRYPOINT ["facter"]
CMD [""]

COPY Dockerfile /
