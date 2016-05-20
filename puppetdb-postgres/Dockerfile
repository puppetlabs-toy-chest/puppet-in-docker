FROM postgres:9.5.2
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL com.puppet.version="0.1.0" com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="97475979ffe252d33a9df67524b5aa313022cb05" com.puppet.buildtime="2016-05-20T10:01:19Z" com.puppet.dockerfile="/Dockerfile"

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

COPY Dockerfile /
