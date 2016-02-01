# tractor-docker

Run [Pixar's Tractor](https://renderman.pixar.com/view/pixars-tractor) using [Docker](https://www.docker.com) containers.

A [Docker Compose file](https://docs.docker.com/compose/) will create a series of containers which are all based on the same [Docker image](https://docs.docker.com/engine/userguide/dockerimages/):
* `pixar_license` - the Pixar License server, required for Tractor to dispatch work
* `tractor_data` - persistent database data in Docker volume and configuration data mapped onto Docker host
* `tractor_engine` - the Tractor Engine server
* `tractor_blade` - a Tractor Blade


## Jeez... ok, so how does this work?

Basically, this will set up everything which is required for Tractor to run, provided you can bring your own RPMs and license (you're a Pixar Tractor customer).

It's really not that complicated. First, check out the `Dockerfile`. We create all containers based on this. Then check out `docker-compose.yml` on which command is being run for each container. That's it, with wide brush strokes, really.


## Notes on customizing the implementation

You may want to change the licensing approach. Maybe you already have a Pixar License Server running somewhere in your network. In this case, you can omit the `license` container block in `docker-compose.yml` and add the `9010` port to the `engine` container block.

You may also want to change the behavior of the Docker volume which holds the Tractor Engine database data. The recommended approach by Docker is to generally keep database data persistent, so that it doesn't get deleted if the container is restarted. You might wish to map such a Docker volume to an actual location on the Docker host. This will require that the non-root Tractor user (default: `farmer`) exist on the Docker host.

Using the default container setup, the local `tractor/assets` folder is mapped to `/opt/pixar/assets` on the `pixar_license` and the `tractor_engine` containers (read-only). This makes it easy to access the configuration and license file from the host running the containers as well as from within the containers.

The `tractor_blade` currently isn't really doing any good and is only supposed to exist to show an example implementation. You might want to base this off another Docker image, or equip the existing Tractor Docker image with additional software. Maybe you you would rather run a Tractor blade from within the `tractor_engine` container. Please note that you shouldn't define a hostname for the `tractor_blade` container if you plan on scaling this container using e.g. `docker-compose blade scale=10`. If you do this, all such blades will share the same hostname and only one blade will show in Tractor Engine. Also, if you wish to scale the blade service, you must comment out its `container_name` attribute in `docker-compose.yml`.

Please note that if you rename the `tractor-docker` directory, the quickstart below will fail.



## Quickstart

#####  1. Download the project:

    git clone https://github.com/fredrikaverpil/tractor-docker.git


#####  2. Prepare the RPMs, Pixar license and Tractor configuration.

* Put the Tractor and PixarLicense server RPMs inside the `tractor-docker/tractor/assets` folder.
* Put your pixar.license file into the `tractor-docker/tractor/assets` folder.
* Copy your Tractor configuration into the `tractor-docker/tractor/assets/custom_config` folder.


#####  3. Verify Dockerfile

* Verify that the `COPY` statements of `tractor-docker/tractor/Dockerfile` contains the correct RPM filenames.
* Verify that the `RUN useradd` statement of `tractor-docker/tractor/Dockerfile` creates the desired (non-root) Tractor user (default: `farmer`).


#####  4. Verify docker-compose.yml

* Verify each `command` statement in `docker-compose.yml` to reflect the correct filepath to `PixarLicenseServer`, `tractor-engine` and `tractor-blade`.


##### 5. Verify tractor.config

* Verify that the `EngineOwner` in `tractor-docker/tractor/assets/tractor.config` uses the desired (non-root) Tractor user (default: `farmer`).
* Verify so that `LicenseLocation` points to `/opt/pixar/assets/pixar.license`.


##### 6. Build the container image

This will build the container image, which will be used for the `pixar_license`, `tractor_data`, `tractor_engine` and `tractor_blade` containers.
    
    cd tractor-docker
    docker-compose build

##### 7. Run the compose

This will create and start the `pixar_license`, `tractor_data`, `tractor_engine` and `tractor_blade` containers based on the `tractordocker_image` container image.

    cd tractor-docker
    docker-compose up


##### 8. Figure out the IP address used to access the Tractor Engine

    docker inspect tractor_engine | grep IPAddress


##### 9. Stop all containers
	
	cd tractor-docker
    docker-compose stop


## Useful commands


##### Enter a running container

    docker exec -i -t CONTAINER_NAME /bin/bash

##### List all running containers

    docker ps # or 'docker ps -a' for all containers

##### Remove the data container along with its volume data

    docker rm -v tractor_data

##### Backup database data

    docker run --rm --volumes-from tractor_data -v $(pwd):/backup centos tar cvf /backup/backup.tar /var/spool/tractor




