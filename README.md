[![Build
Status](https://travis-ci.org/puppetlabs/puppet-in-docker.svg?branch=master)](https://travis-ci.org/puppetlabs/puppet-in-docker)

# Puppet-in-Docker

A series of Dockerfiles, and the associated build toolchain, for building Docker images containing Puppet and related software.

## Experimental

This approach to packaging Puppet software is experimental. The resulting images are not a supported way of running Puppet or Puppet Enterprise and are likely to change quickly based on feedback from users. Please do try them out and let us know what you think.

## Description

You can copy the individual Dockerfiles in this repo and use them locally for your own purposes. They were created following current Docker best practices, and can be good starting points for custom images.

If you do find yourself customizing these images, please open issues describing why and whether your use is something that could be handled in these images.

You can find published versions of these images on [Docker Hub](https://hub.docker.com/u/puppet):

* [![](https://images.microbadger.com/badges/image/puppet/puppet-agent-ubuntu.svg)](http://microbadger.com/images/puppet/puppet-agent-ubuntu) [![](https://images.microbadger.com/badges/version/puppet/puppet-agent-ubuntu.svg)](http://microbadger.com/images/puppet/puppet-agent-ubuntu) [puppet/puppet-agent-ubuntu](https://hub.docker.com/r/puppet/puppet-agent-ubuntu/)
* [![](https://images.microbadger.com/badges/image/puppet/puppetserver-standalone.svg)](http://microbadger.com/images/puppet/puppetserver-standalone) [![](https://images.microbadger.com/badges/version/puppet/puppetserver-standalone.svg)](http://microbadger.com/images/puppet/puppetserver-standalone) [puppet/puppetserver-standalone](https://hub.docker.com/r/puppet/puppetserver-standalone/)
* [![](https://images.microbadger.com/badges/image/puppet/facter.svg)](http://microbadger.com/images/puppet/facter) [![](https://images.microbadger.com/badges/version/puppet/facter.svg)](http://microbadger.com/images/puppet/facter) [puppet/facter](https://hub.docker.com/r/puppet/facter/)
* [![](https://images.microbadger.com/badges/image/puppet/puppetserver.svg)](http://microbadger.com/images/puppet/puppetserver) [![](https://images.microbadger.com/badges/version/puppet/puppetserver.svg)](http://microbadger.com/images/puppet/puppetserver) [puppet/puppetserver](https://hub.docker.com/r/puppet/puppetserver/)
* [![](https://images.microbadger.com/badges/image/puppet/puppet-agent-alpine.svg)](http://microbadger.com/images/puppet/puppet-agent-alpine) [![](https://images.microbadger.com/badges/version/puppet/puppet-agent-alpine.svg)](http://microbadger.com/images/puppet/puppet-agent-alpine) [puppet/puppet-agent-alpine](https://hub.docker.com/r/puppet/puppet-agent-alpine/)
* [![](https://images.microbadger.com/badges/image/puppet/puppetexplorer.svg)](http://microbadger.com/images/puppet/puppetexplorer) [![](https://images.microbadger.com/badges/version/puppet/puppetexplorer.svg)](http://microbadger.com/images/puppet/puppetexplorer) [puppet/puppetexplorer](https://hub.docker.com/r/puppet/puppetexplorer/)
* [![](https://images.microbadger.com/badges/image/puppet/puppetdb-postgres.svg)](http://microbadger.com/images/puppet/puppetdb-postgres) [![](https://images.microbadger.com/badges/version/puppet/puppetdb-postgres.svg)](http://microbadger.com/images/puppet/puppetdb-postgres) [puppet/puppetdb-postgres](https://hub.docker.com/r/puppet/puppetdb-postgres/)
* [![](https://images.microbadger.com/badges/image/puppet/puppetboard.svg)](http://microbadger.com/images/puppet/puppetboard) [![](https://images.microbadger.com/badges/version/puppet/puppetboard.svg)](http://microbadger.com/images/puppet/puppetboard) [puppet/puppetboard](https://hub.docker.com/r/puppet/puppetboard/)
* [![](https://images.microbadger.com/badges/image/puppet/puppetdb.svg)](http://microbadger.com/images/puppet/puppetdb) [![](https://images.microbadger.com/badges/version/puppet/puppetdb.svg)](http://microbadger.com/images/puppet/puppetdb) [puppet/puppetdb](https://hub.docker.com/r/puppet/puppetdb/)
* [![](https://images.microbadger.com/badges/image/puppet/puppet-agent-centos.svg)](http://microbadger.com/images/puppet/puppet-agent-centos) [![](https://images.microbadger.com/badges/version/puppet/puppet-agent-centos.svg)](http://microbadger.com/images/puppet/puppet-agent-centos) [puppet/puppet-agent-centos](https://hub.docker.com/r/puppet/puppet-agent-centos/)
* [![](https://images.microbadger.com/badges/image/puppet/puppet-agent-debian.svg)](http://microbadger.com/images/puppet/puppet-agent-debian) [![](https://images.microbadger.com/badges/version/puppet/puppet-agent-debian.svg)](http://microbadger.com/images/puppet/puppet-agent-debian) [puppet/puppet-agent-debian](https://hub.docker.com/r/puppet/puppet-agent-debian/)
* [![](https://images.microbadger.com/badges/image/puppet/puppet-inventory.svg)](http://microbadger.com/images/puppet/puppet-inventory) [![](https://images.microbadger.com/badges/version/puppet/puppet-inventory.svg)](http://microbadger.com/images/puppet/puppet-inventory) [puppet/puppet-inventory](https://hub.docker.com/r/puppet/puppet-inventory/)
* [![](https://images.microbadger.com/badges/image/puppet/r10k.svg)](http://microbadger.com/images/puppet/r10k) [![](https://images.microbadger.com/badges/version/puppet/r10k.svg)](http://microbadger.com/images/puppet/r10k) [puppet/r10k](https://hub.docker.com/r/puppet/r10k/)


## Image usage

You can use the images for standing up various Puppet applications on Docker. For a complete set of examples see the [Puppet in Docker examples repository](https://github.com/puppetlabs/puppet-in-docker-examples).

As an example, first we'll create a Docker network. For the purposes of this demonstration, we're using the network and service discovery features added in Docker 1.11.

```
docker network create puppet
```

Then we can run a copy of Puppet Server. In the below code, `standalone` means that this image does not automatically connect to PuppetDB. That's fine for this simple demo, but in other cases you might prefer the `puppet/puppetserver` image.

```
docker run --net puppet --name puppet --hostname puppet puppet/puppetserver-standalone
```

This boots the container and, becuase we're running in the foreground, it prints lots of output to the console. After this is running, we can run a Puppet agent in another container.

```
docker run --net puppet puppet/puppet-agent-ubuntu
```

This connects to the Puppet Server, applies the resulting catalog, prints a summary, and then exits. That's not very useful apart from development purposes, but this is just a basic demonstration. See the above examples repository for fuller examples, or
consider:

### Running periodically

The above example runs with the `onetime` flag, which means that Puppet exits after the first run. The container can be run with any arbitrary Puppet commands, such as:

```
docker run --net puppet puppet/puppet-agent-ubuntu agent --verbose --no-daemonize --summarize
```

This container won't exit, and instead applies Puppet every 30 minutes based on the latest content from the Puppet Server.

### Puppet resource

You can also use other Puppet commands, such as `resource`. For instance, the following command lists all of the packages installed on the image.

```
docker run puppet/puppet-agent-ubuntu resource package --param provider
```

To find out about the packages installed on the host, rather than in the container, mount in various folder from the host like so.

```
docker run --privileged -v /tmp:/tmp --net host -v /etc:/etc -v /var:/var -v /usr:/usr -v lib64:/lib64 puppet/puppet-agent-ubuntu resource package
```

The same approach works with the Facter image as well.

```
docker run --privileged -v /tmp:/tmp --net host -v /etc:/etc -v /var:/var -v /usr:/usr -v lib64:/lib64 puppet/facter os
```

### API

The resulting images expose a label-based API for gathering information about the image or for use in further automation. For example:

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

Please suggest other standard fields for inclusion in the API. Over time, a formal specification may be created, along with further tooling, but this is an experimental feature.

## Toolchain

The repository contains a range of tools for managing the set of Dockerfiles and the resulting images. For instance, you can list the images available.

Note that using the toolchain requires a Ruby environment and Bundler. You'll also need a local Docker installation.

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

### Building images

The following command builds the `puppet-agent-alpine` image. You can find the relevant Dockerfile in the directory of the same name.

```
$ bundle exec rake puppet-agent-alpine:build
```

This is a simple interface to run `docker build` and creates both a latest and a versioned Docker image in your local repository.

### Testing images

The repository provides two types of tests:

1. Validation of the Dockerfile using [Hadolint](https://github.com/lukasmartinelli/hadolint)
2. Acceptance tests of the image using [ServerSpec](http://serverspec.org)

These can be run individually or together. To run them together, use the following command.

```
$ bundle exec rake puppet-agent-alpine:test
```

### Additional commands

The included toolchain allows you to run lint checks, bump version information, run acceptance tests, build, and then publish the resulting Docker images. You can access the toolchain with `rake`.

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

## Adding additional images

To add additional images to the repository, create a folder in the root of the repository and include in that folder a standard Dockerfile. The above commands should auto-discover the new image. We recommend that you also include a spec folder containing tests verifying the image's behavior. See examples in the other folders for help getting started. Please suggest new images via pull request.

## Maintainers

This repository is maintained by: Gareth Rushgrove <gareth@puppet.com>.

Individual images may have separate maintainers as mentioned in the relevant Dockerfiles.
