FROM puppet/puppet-agent-ubuntu:1.5.0
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL com.puppet.version=$PUPPET_AGENT_VERSION com.puppet.git.sha="84ef5116015687ce02a43dacddb3d7f7c1dc9282" com.puppet.buildtime="2016-05-18T10:51:16Z"

COPY Dockerfile /

ENTRYPOINT ["facter"]
CMD [""]
