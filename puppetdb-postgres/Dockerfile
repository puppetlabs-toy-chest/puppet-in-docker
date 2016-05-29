FROM postgres:9.5.2
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL com.puppet.version="0.1.0" com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="ca4b5726dd0e244b04ed7f84d6568f79943c91ce" com.puppet.buildtime="2016-05-29T08:18:48Z" com.puppet.dockerfile="/Dockerfile"

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

COPY Dockerfile /
