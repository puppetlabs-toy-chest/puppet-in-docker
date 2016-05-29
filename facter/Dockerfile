FROM puppet/puppet-agent-ubuntu:1.5.0
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL com.puppet.version=$PUPPET_AGENT_VERSION com.puppet.git.sha="ca4b5726dd0e244b04ed7f84d6568f79943c91ce" com.puppet.buildtime="2016-05-29T08:18:48Z"

ENTRYPOINT ["facter"]
CMD [""]

COPY Dockerfile /
