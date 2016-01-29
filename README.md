# tractor-docker

Run [Pixar's Tractor](https://renderman.pixar.com/view/pixars-tractor) in a [Docker](https://www.docker.com) container.


### Quickstart



#####  1. Download the project:

    git clone https://github.com/fredrikaverpil/tractor-docker.git


#####  2. Prepare the RPMs, Pixar license and Tractor configuration.

* Put the Tractor and PixarLicense server RPMs inside the `tractor-docker/tractor` folder.
* Put your pixar.license file into the `tractor-docker/tractor/assets` folder.
* Copy your Tractor configuration into `tractor-docker/tractor/assets/custom_config`.


#####  3. Verify Dockerfile

* Verify that the `COPY` statements of `tractor-docker/tractor/Dockerfile` contains the correct RPM filenames.
* Verify that the `RUN useradd` statement of `tractor-docker/tractor/Dockerfile` creates the desired (non-root) Tractor user (default: `farmer`).


#####  4. Verify docker-compose.yml

* Verify each `command` to reflect the correct filepath to `PixarLicenseServer`, `tractor-engine` and `tractor-blade`.


##### 5. Verify tractor.config

* Verify that the `EngineOwner` in `tractor-docker/tractor/assets/tractor.config` uses the desired (non-root) Tractor user (default: `farmer`).


##### 6. Build the container image

This will build the container image, which will be used for the `pixar_license`, `tractor_dbdata`, `tractor_engine` and `tractor_blade` containers.
    
    cd tractor-docker
    docker-compose build

##### 7. Run the compose

This will create and start the `pixar_license`, `tractor_dbdata`, `tractor_engine` and `tractor_blade` containers based on the `tractordocker_image` container image.

    docker-compose up


##### 8. Figure out the IP address used to access the Tractor Engine

OS X: `docker-machine ip`
Windows: `docker-machine ip`

