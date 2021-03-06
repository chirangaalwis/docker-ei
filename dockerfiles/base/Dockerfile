# ------------------------------------------------------------------------
#
# Copyright 2017 WSO2, Inc. (http://wso2.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License
#
# ------------------------------------------------------------------------

# set to latest Ubuntu LTS
FROM ubuntu:16.04
MAINTAINER WSO2 Docker Maintainers "dev@wso2.org"

# set user configurations
ARG USER=wso2carbon
ARG USER_ID=802
ARG USER_GROUP=wso2
ARG USER_GROUP_ID=802
ARG USER_HOME=/home/${USER}
# set dependant files directory
ARG FILES=./files
# set wso2 product configurations
ARG WSO2_SERVER=wso2ei
ARG WSO2_SERVER_VERSION=6.1.1
ARG WSO2_SERVER_DIST=${WSO2_SERVER}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER_DIST}
# set jdk configurations
ARG JDK_DIST=jdk1.8.0*
ARG JAVA_HOME=${USER_HOME}/java

# install required packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
    curl && \
    rm -rf /var/lib/apt/lists/*

# create a user group and a user
RUN groupadd --system -g ${USER_GROUP_ID} ${USER_GROUP} && \
    useradd --system --create-home --home-dir ${USER_HOME} --no-log-init -g ${USER_GROUP_ID} -u ${USER_ID} ${USER}

# copy jdk, wso2 product distribution to user's home directory and copy mysql connector jar to product distribution
COPY --chown=wso2carbon:wso2 ${FILES}/${JDK_DIST} ${JAVA_HOME}
COPY --chown=wso2carbon:wso2 ${FILES}/${WSO2_SERVER_DIST} ${WSO2_SERVER_HOME}
COPY --chown=wso2carbon:wso2 ${FILES}/mysql-connector-java-*-bin.jar ${WSO2_SERVER_HOME}/lib

# set the user and work directory
USER ${USER}
WORKDIR ${USER_HOME}

# set environment variables
ENV JAVA_HOME=${JAVA_HOME} \
    PATH=$JAVA_HOME/bin:$PATH \
    WSO2_SERVER_HOME=${WSO2_SERVER_HOME}
