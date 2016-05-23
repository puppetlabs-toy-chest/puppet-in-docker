A series of dockerfiles, and associated build toolchain, for building
Docker images for for Puppet and related software.

# Experimental

This approach to packaging Puppet software is currently experimental.
The resulting images are not a supported way of running Puppet or Puppet
Enterprise and are likely to change quickly based on feedback from
users. Please do try them out and let us know what you think.

# Description

The individual Dockerfile's available in this repo can be copied and
used locally for your own purposes. They may act as a good starting
point for custom images and aim to follow current Docker best practices.
If you do find yourself customising them please open issues describing
why and whether this could be handled in these images.

You can find published versions of these images on [Docker Hub](https://hub.docker.com/puppet).

# Image usage

The images allow for standing up various Puppet applications on Docker.
For a complete set of examples see the [Puppet in Docker examples
repository](https://github.com/puppetlabs/puppet-in-docker-examples).
As a simple example:

First we'll create a docker network. For the purposes of this
demonstration we're using the network and service discovery features
added in Docker 1.11.

```
docker network create puppet
```

Then we can run a copy of Puppet Server. The `standalone` part refers to
the fact this image does not automatically connect to PuppetDB. That's
fine for this simple demo, but in other cases you may prefer the
`puppet/puppetserver` image.

```
docker run --net puppet --name puppet --hostname puppet puppet/puppetserver-standalone
```

The container should boot and, as we're running in the foreground, it
should print lot output to the console. Once running we can run a simple
puppet agent in another container.

```
docker run --net puppet puppet/puppet-agent-ubuntu
```

This should connect to the Puppet Server, apply the resulting
catalog, print a summary and then exit. Now that's not very useful
(apart from for development purposes) but that's just a hello world
demonstration. See the above examples repository for fuller examples, or
consider:

### Running periodically

The above example runs with the `onetime` flag. which means Puppet
exits after the first run. The container can be run with any arbitrary puppet commands, for
example:

```
docker run --net puppet puppet/puppet-agent-ubuntu agent --verbose --no-daemonize -summarize
```

This container won't exit, and instead will apply Puppet every 30
minutes based on the latest content from the Puppet Server.

### Puppet resource

Puppet provides more than just the `agent` or `apply` commands. One
notable example is `resource`. For instance the following command will
list all of the packages installed on the image.

```
docker run puppet/puppet-agent-ubuntu resource package --param provider
```

You may however be more interested in the packages installed on the host
rather than in the container. For that you can mount in various folder
from the host like so.

```
docker run --privileged -v /tmp:/tmp --net host -v /etc:/etc -v /var:/var -v /usr:/usr -v lib64:/lib64 puppet/puppet-agent-ubuntu resource package
```

Note that the same approach works with the facter image too.

```
docker run --privileged -v /tmp:/tmp --net host -v /etc:/etc -v /var:/var -v /usr:/usr -v lib64:/lib64 puppet/facter os
```

## API

The resulting images expose a label based API for gathering information
about the image or for use in further automation. For example:

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

Please suggest other standard fields for inclusion in the API. Over time
a formal specification maybe created along with further tooling but this
is currently an experimental feature.

# Toolchain

The repository contains a range of tools for managing the set of
Dockerfiles and resulting images. For instance listing the images
available.

Note that using the toolchain requires a Ruby environment and
Bundler installed. You'll also need a local Docker installation.

```
$ bundle install
...
$ bundle exec rake list
NAME                    | VERSION | FROM                                 | SHA                                      | BUILD                | MAINTAINER
------------------------|---------|--------------------------------------|------------------------------------------|----------------------|-------------------------------------
facter                  | 1.5.0   | puppet/puppet-agent-ubuntu:1.5.0     | 97475979ffe252d33a9df67524b5aa313022cb05 | 2016-05-20T10:01:19Z | Gareth Rushgrove "gareth@puppet.com"
puppet-agent-alpine     | 4.4.2   | alpine:3.3                           | 97475979ffe252d33a9df67524b5aa313022cb05 | 2016-05-20T10:01:19Z | Gareth Rushgrove "gareth@puppet.com"
puppet-agent-ubuntu     | 1.5.0   | ubuntu:16.04                         | 97475979ffe252d33a9df67524b5aa313022cb05 | 2016-05-20T10:01:19Z | Gareth Rushgrove "gareth@puppet.com"
puppetboard             | 0.1.3   | alpine:3.3                           | 97475979ffe252d33a9df67524b5aa313022cb05 | 2016-05-20T10:01:19Z | Gareth Rushgrove "gareth@puppet.com"
puppetdb                | 4.1.0   | ubuntu:16.04                         | 97475979ffe252d33a9df67524b5aa313022cb05 | 2016-05-20T10:01:19Z | Gareth Rushgrove "gareth@puppet.com"
puppetdb-postgres       | 0.1.0   | postgres:9.5.2                       | 97475979ffe252d33a9df67524b5aa313022cb05 | 2016-05-20T10:01:19Z | Gareth Rushgrove "gareth@puppet.com"
puppetexplorer          | 2.0.0   | alpine:3.3                           | 97475979ffe252d33a9df67524b5aa313022cb05 | 2016-05-20T10:01:19Z | Gareth Rushgrove "gareth@puppet.com"
puppetserver            | 2.3.2   | puppet/puppetserver-standalone:2.4.0 | 161bca4fed59997fd19581df38678caeefe813bc | 2016-05-16T08:05:27Z | Gareth Rushgrove "gareth@puppet.com"
puppetserver-standalone | 2.4.0   | ubuntu:16.04                         | 97475979ffe252d33a9df67524b5aa313022cb05 | 2016-05-20T10:01:19Z | Gareth Rushgrove "gareth@puppet.com"
```

## Building images

The following command will build the _puppet-agent-alpine_ image, the
relevant Dockerfile can be found in the directory of the same name.

```
$ bundle exec rake puppet-agent-alpine:build
```

This is just a simple interface to running `docker build` and should
create both a latest and versioned Docker image in your local
repository.

## Testing images

The repository provides two types of tests:

1. Validation of the Dockerfile using
   [Hadolint](https://github.com/lukasmartinelli/hadolint)
2. Acceptance tests of the image using [ServerSpec](http://serverspec.org)

These can be run individually or together, the later using the following
command.

```
$ bundle exec rake puppet-agent-alpine:test
```

## Additional commands

The included toolchain provides a way of running lint checks, bumping
version information, running acceptance tests, building and then publishing the
resulting Docker images. It is accessed via rake.

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
...
rake test                         # Run test for all images in repository in parallel
rake rev                          # Run rev for all images in repository in parallel
rake rubocop                      # Run RuboCop
rake rubocop:auto_correct         # Auto-correct RuboCop offenses
rake spec                         # Run spec for all images in repository in parallel
rake test                         # Run test for all images in repository in parallel
```

# Adding additional images

Additional images can be easily added to the repository. Simply create a
folder in the root of the repository and include in that folder a
standard Dockerfile. The above commands should auto-discover the new
image. Note that it is recommended to also include a spec folder
containing tests verifying the images behaviour. See examples in the
other folders for help getting started. Please suggest new images via
pull request.

# Maintainers

This repository is maintained by: Gareth Rushgrove <gareth@puppet.com>.
Individual images may have separate maintainers as mentioned in the
relevant Dockerfiles.
