FROM puppet/puppet-agent-ubuntu:1.6.0
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL com.puppet.version=$PUPPET_AGENT_VERSION com.puppet.git.sha="ffeb9772ad67da19d12b69a898fd431c919188ed" com.puppet.buildtime="2016-08-12T08:14:20Z"

ENTRYPOINT ["facter"]
CMD [""]

COPY Dockerfile /
