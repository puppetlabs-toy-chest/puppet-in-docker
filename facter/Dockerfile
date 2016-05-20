FROM puppet/puppet-agent-ubuntu:1.5.0
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL com.puppet.version=$PUPPET_AGENT_VERSION com.puppet.git.sha="97475979ffe252d33a9df67524b5aa313022cb05" com.puppet.buildtime="2016-05-20T10:01:19Z"

ENTRYPOINT ["facter"]
CMD [""]

COPY Dockerfile /
