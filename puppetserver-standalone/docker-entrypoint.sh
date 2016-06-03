#!/bin/bash

chown -R puppet:puppet /etc/puppetlabs/puppet/ssl

exec /opt/puppetlabs/bin/puppetserver "$@"
