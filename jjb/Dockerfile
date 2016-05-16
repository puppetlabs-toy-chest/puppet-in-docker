FROM jenkins:1.651.2

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

USER root

RUN apt-get update && \
    apt-get install --no-install-recommends -y ruby-dev=1:2.1.5+deb8u2 rubygems && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN gem install bundler
