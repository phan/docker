# phan/docker

An installation of PHP8 and [Phan][phan] in a super tiny [Alpine Linux][alpine]
Docker image. The image is just 30 MB and runs interactively on the files
outside your container, making it easy to statically analyze PHP code.

[phan/docker](https://github.com/phan/docker) is a fork of [cloudflare/docker-phan](cloudflare-docker-phan)

## Motivations

Phan requires PHP7.2+ and specific PHP extensions to be installed. PHP7.2+ isn’t
packaged yet for many Linux distributions and users would still need to compile
and enable the extra PHP extensions.

By packaging Phan inside a Docker image, we can separate the runtime and
configuration of the tool from your application’s environment and requirements.

## Getting phan/docker

The easiest way to use `phan/docker` is to create a shell function for “phan”
that makes makes it nearly transparent that phan is running inside Docker.

```sh
phan() { docker run -v $PWD:/mnt/src --rm -u "$(id -u):$(id -g)" phanphp/phan:latest $@; return $?; }
```

(You may replace “latest” with a tagged Phan release such as `3` or `3.0` or `3.0.4` to use a specific version of Phan.)

## Running phan/docker
> If you’re just getting started with Phan, you should follow Phan’s excellent
[Tutorial for Analyzing A Large Sloppy Code Base][phan-tutorial] to setup the
initial configuration for your project.

All of Phan’s command line flags can be passed to `phan/docker`.

## Example

To create an “analysis.txt” in the current directory for further processing

``` sh
phan -po analysis.txt
```

To run phan on a project that already has a `.phan/config.php` set up (assuming no symlinks)

```sh
cd /path/to/project
# short for: docker run -v $PWD:/mnt/src --rm -u "$(id -u):$(id -g)" phanphp/phan:latest
phan
```

## Building

Docker images are built with the `build` script based on the awesome building
and testing framework put into place by the [`docker-alpine`][docker-alpine]
contributors. See [BUILD.md][build-docs] for more information.

## Phan reports that classes from a PHP module are missing

### Configuring Stubs

This aims to be a minimal docker image, and does not include many common PHP modules(extensions).

See https://github.com/phan/phan/wiki/How-To-Use-Stubs#internal-stubs for how to generate stubs from installed extensions and configure phan to use those stubs if the extension is not installed.

### Extending phan/docker with extra PHP modules

Installing the PHP modules may give phan better type information than stubs in some cases.

See [`examples/installing_extensions`](https://github.com/phan/docker/tree/master/examples/installing_extensions) for how to do that.

## License

[BSD 2-Clause License][bsd-2-clause]

[phan]: https://github.com/phan/phan
[alpine]: http://www.alpinelinux.org/
[phan-tutorial]: https://github.com/phan/phan/wiki/Tutorial-for-Analyzing-a-Large-Sloppy-Code-Base
[docker-alpine]: https://github.com/gliderlabs/docker-alpine
[build-docs]: BUILD.md
[bsd-2-clause]: https://tldrlegal.com/license/bsd-2-clause-license-(freebsd)#summary
[cloudflare-docker-phan]: https://github.com/cloudflare/docker-phan
