FROM postgres:9.5.3
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL com.puppet.version="0.1.0" com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="ffeb9772ad67da19d12b69a898fd431c919188ed" com.puppet.buildtime="2016-08-12T08:14:20Z" com.puppet.dockerfile="/Dockerfile"

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

COPY Dockerfile /
