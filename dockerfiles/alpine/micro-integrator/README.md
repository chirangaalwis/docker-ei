# Dockerfile for WSO2 Micro Integrator #

This section defines the step-by-step instructions to build an [Alpine](https://hub.docker.com/_/alpine/) Linux based Docker image for WSO2 Micro Integrator 1.1.0.

## Prerequisites

* [Docker](https://www.docker.com/get-docker) v17.09.0 or above
* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) client

## How to build an image and run

##### 1. Checkout this repository into your local machine using the following Git client command.

```
git clone https://github.com/wso2/docker-ei.git
```

>The local copy of the `dockerfiles/alpine/micro-integrator` directory will be referred to as `MI_DOCKERFILE_HOME` from this point onwards.

##### 2. Build the Docker image.

- Navigate to `<MI_DOCKERFILE_HOME>` directory. <br>
  Execute `docker build` command as shown below.
    + `docker build -t wso2mi:1.1.0-alpine .`

> By default, the Docker image will prepackage the General Availability (GA) release version of the relevant WSO2 product.

##### 3. Running the Docker image.

- `docker run -p 8253:8253 -p 8290:8290 wso2mi:1.1.0-alpine`

## How to update configurations

Configurations would lie on the Docker host machine and they can be volume mounted to the container. <br>
As an example, steps required to change the port offset using `deployment.toml` is as follows:

##### 1. Stop the MI container if it's already running.

In WSO2 MI 1.1.0 product distribution, `deployment.toml` configuration file can be found at `<DISTRIBUTION_HOME>/conf`.<br>
Copy the file to some suitable location of the host machine, referred to as `<SOURCE_CONFIGS>/deployment.toml` and change the<br>
offset value (`[server]->offset`) to 11.

##### 2. Grant read permission to `other` users for `<SOURCE_CONFIGS>/deployment.toml`.

```
chmod o+r <SOURCE_CONFIGS>/deployment.toml
```

##### 3. Run the image by mounting the file to container as follows:

```
docker run \
-p 8254:8254 \
--volume <SOURCE_CONFIGS>/deployment.toml:<TARGET_CONFIGS>/deployment.toml \
wso2mi:1.1.0-alpine
```

> In here, <TARGET_CONFIGS> refers to /home/wso2carbon/wso2mi-1.1.0/conf folder of the container.

## Docker command usage references

* [Docker build command reference](https://docs.docker.com/engine/reference/commandline/build/)
* [Docker run command reference](https://docs.docker.com/engine/reference/run/)
* [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
