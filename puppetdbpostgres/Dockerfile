FROM postgres:9.5.2
MAINTAINER Gareth Rushgrove "gareth@puppetlabs.com"

LABEL com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="30bdf611465e2296ec01facf7dc1ee73efd85af7" com.puppet.build-time="2016-05-09T14:27:10Z" com.puppet.dockerfile="/Dockerfile"

COPY Dockerfile /
COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
