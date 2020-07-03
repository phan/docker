Extending phan/docker with extensions
-------------------------------------

This image can be extended to install PHP modules that the analyzed project uses (for analyzing that project),
or to install PHP modules that third party plugins for Phan depend on.

For example, from within this directory, run `docker build --tag=phan-with-extra-extensions:3` to install the extra PHP modules in [the Dockerfile](Dockerfile)

Then `docker run --rm -it --volume ~/programming/phan:/mnt/src  phan-with-extra-extensions:3` will run Phan with those extra PHP modules

For many use cases, https://github.com/phan/phan/wiki/How-To-Use-Stubs#internal-stubs may be a better alternative.
