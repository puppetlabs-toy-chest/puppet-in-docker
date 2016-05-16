FROM postgres:9.5.2
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="161bca4fed59997fd19581df38678caeefe813bc" com.puppet.buildtime="2016-05-09T14:27:10Z" com.puppet.dockerfile="/Dockerfile"

COPY Dockerfile /
COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
