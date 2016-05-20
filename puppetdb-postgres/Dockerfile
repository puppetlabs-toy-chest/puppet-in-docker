FROM postgres:9.5.2
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL com.puppet.version="0.1.0" com.puppet.git.repo="https://github.com/puppetlabs/dockerfiles" com.puppet.git.sha="c685b01efe95d7268a6e35f14dff30aa92c37cef" com.puppet.buildtime="2016-05-18T16:35:37Z" com.puppet.dockerfile="/Dockerfile"

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

COPY Dockerfile /
