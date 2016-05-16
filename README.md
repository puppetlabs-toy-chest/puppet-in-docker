A series of dockerfiles, and associated build toolchain, for Puppet and
related software.

# Experimental

This approach to packaging Puppet software is currently experimental.
The resulting images are not a supported way of running Puppet
Enterprise and are likely to change quickly based on feedback from
users. Please do try them out and let us know what you think.

# Description

The individual Dockerfile's available in this repo can be copied and
used locally for your own purposes. They can act as a good starting
point for custom images and aim to follow current Docker best practices.
If you do find yourself customising them please open issues describing
why and whether this could be handled in these images.

These are also published to [Docker Hub](https://hub.docker.com/puppet).

# Usage

The repository contains a range of tools for managing the set of
Dockerfiles. For instance you can list the existing images available.

```
$ bundle install
...
$ be rake list
NAME                    | VERSION  | FROM                                 | SHA                                      | BUILD                | MAINTAINER
------------------------|----------|--------------------------------------|------------------------------------------|----------------------|-------------------------------------
puppet-agent-alpine     | 4.4.2    | alpine:3.3                           | 80a406f29bfcb95d0b08bdf868d048ab1cdadf6a | 2016-05-09T16:43:46Z | Gareth Rushgrove "gareth@puppet.com"
puppet-agent-ubuntu     | 1.4.1    | ubuntu:14.04                         | 161bca4fed59997fd19581df38678caeefe813bc | 2016-05-16T08:05:27Z | Gareth Rushgrove "gareth@puppet.com"
puppetdb                | 4.0.2    | ubuntu:14.04                         | 161bca4fed59997fd19581df38678caeefe813bc | 2016-05-16T08:05:27Z | Gareth Rushgrove "gareth@puppet.com"
puppetdbpostgres        |          | postgres:9.5.2                       | 161bca4fed59997fd19581df38678caeefe813bc | 2016-05-09T14:27:10Z | Gareth Rushgrove "gareth@puppet.com"
puppetserver            | 2.3.2    | puppet/puppetserver-standalone:2.3.2 | 161bca4fed59997fd19581df38678caeefe813bc | 2016-05-16T08:05:27Z | Gareth Rushgrove "gareth@puppet.com"
puppetserver-standalone | 2.3.2    | ubuntu:14.04                         | 161bca4fed59997fd19581df38678caeefe813bc | 2016-05-16T08:05:27Z | Gareth Rushgrove "gareth@puppet.com"
```

# API

The resulting images expose a label based API for gathering information
about the image or for use in automation. For example:

```
$ docker inspect -f "{{json .Config.Labels }}" puppet/puppet-agent-ubuntu | jq
{
  "com.puppet.build-time": "2016-05-09T12:14:22Z",
  "com.puppet.dockerfile": "/Dockerfile",
  "com.puppet.git.repo": "https://github.com/puppetlabs/dockerfiles",
  "com.puppet.git.sha": "33f00f35d7275a6ca2a538650b9530734aa66929",
  "com.puppet.version": "1.4.1"
}
```

# Toolchain

The bundled toolchain provides a way of running lint checks, acceptance
tests, building and publishing resulting Docker images. It is accessed via rake.

```
$ bundle exec rake -T
rake all                          # Run all for all images in repository in parallel
rake build                        # Run build for all images in repository in parallel
rake lint                         # Run lint for all images in repository in parallel
rake publish                      # Run publish for all images in repository in parallel
rake puppet-agent-alpine:build    # Build docker image
rake puppet-agent-alpine:lint     # Run Hadolint against the Dockerfile
rake puppet-agent-alpine:publish  # Publish docker image
rake puppet-agent-alpine:rev      # Update Dockerfile label content for new version
rake puppet-agent-alpine:spec     # Run RSpec code examples
rake puppet-agent-ubuntu:build    # Build docker image
rake puppet-agent-ubuntu:lint     # Run Hadolint against the Dockerfile
rake puppet-agent-ubuntu:publish  # Publish docker image
rake puppet-agent-ubuntu:rev      # Update Dockerfile label content for new version
rake puppet-agent-ubuntu:spec     # Run RSpec code examples
rake puppetserver:build           # Build docker image
rake puppetserver:lint            # Run Hadolint against the Dockerfile
rake puppetserver:publish         # Publish docker image
rake puppetserver:rev             # Update Dockerfile label content for new version
rake puppetserver:spec            # Run RSpec code examples
rake rubocop                      # Run RuboCop
rake rubocop:auto_correct         # Auto-correct RuboCop offenses
rake test                         # Run test for all images in repository in parallel
```

# Maintainers

This repository is maintained by: Gareth Rushgrove <gareth@puppet.com>.
Individual images may have separate maintainers as mentioned in the
relevant Dockerfiles.
