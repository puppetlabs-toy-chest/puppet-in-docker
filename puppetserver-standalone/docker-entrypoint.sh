#!/bin/bash

set -e

chown -R puppet:puppet /etc/puppetlabs/puppet/ssl

if test -n "${PUPPETDB_SERVER_URLS}" ; then
  echo "Setting up PuppetDB: ${PUPPETDB_SERVER_URLS}..."
  sed -i "s@^server_urls.*@server_urls = ${PUPPETDB_SERVER_URLS}@" /etc/puppetlabs/puppet/puppetdb.conf
fi

# If a Puppet control repo has been specified then let's config r10k and deploy all branches.
if test -n "${CONTROL_REPO_GIT_URI}"; then
    mkdir -p /etc/puppetlabs/r10k 
    echo "Setting up Puppet control repo with r10k: ${CONTROL_REPO_GIT_URI}..."
cat <<HERE > /etc/puppetlabs/r10k/r10k.yaml
---
:cachedir: '/opt/puppetlabs/r10k/cache'

:sources:
  :site:
    remote: ${CONTROL_REPO_GIT_URI}
    basedir: '/etc/puppetlabs/code/environments'
HERE
    /opt/puppetlabs/puppet/bin/r10k deploy environment --puppetfile --verbose
fi

exec /opt/puppetlabs/bin/puppetserver "$@"
