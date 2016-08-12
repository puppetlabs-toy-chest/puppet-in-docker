FROM postgres:9.5.3
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL com.puppet.version="0.1.0" com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="b441445ca4c565eee2536bd01260c498012d5c5b" com.puppet.buildtime="2016-08-12T07:55:18Z" com.puppet.dockerfile="/Dockerfile"

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

COPY Dockerfile /
