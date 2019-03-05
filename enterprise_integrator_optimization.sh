#!/usr/bin/env bash

# ----------------------------------------------------------------------------
#
# Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
#
# WSO2 Inc. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# ----------------------------------------------------------------------------

product="wso2ei"
version="6.2.0"
profile="integrator"
platform="ubuntu"

docker_resource_repo=`pwd`
dockerfile_home="${docker_resource_repo}/dockerfiles/${platform}/${profile}"
build_context_artifacts="${dockerfile_home}/files"

if [ ! -f ${build_context_artifacts}/${product}-${version}*.zip ]; then
    echo "The product distribution not found!"
    exit 1
fi

if ! unzip ${build_context_artifacts}/${product}-${version}*.zip -d ${build_context_artifacts} ; then
    echo "Failed to extract the product distribution!"
    exit 1
fi

if [ ! -d ${build_context_artifacts}/${product}-${version} ]; then
    echo "The extracted product distribution not found!"
    exit 1
fi

if ! rm ${build_context_artifacts}/${product}-${version}*.zip ; then
    echo "Failed to remove the profile optimized product distribution!"
    exit 1
fi

echo "Extraction of the product distribution successful!!!"

if ! chmod u+x ${build_context_artifacts}/${product}-${version}/bin/profile-creator.sh ; then
    echo "Failed to set the execute permission for owner of the WSO2 EI profile optimization script!"
    exit 1
fi

if ! echo "1" | ${build_context_artifacts}/${product}-${version}/bin/profile-creator.sh ; then
    echo "Failed to generate the profile optimized product distribution!"
    exit 1
fi

if [ ! -f ${build_context_artifacts}/${product}-${version}_${profile}.zip ]; then
    echo "Profile optimized product distribution not found!"
    exit 1
fi

if ! rm -rf ${build_context_artifacts}/${product}-${version} ; then
    echo "Failed to remove the extracted original product distribution!"
    exit 1
fi

echo "Generation of the optimized product distribution successful!!!"

if ! unzip ${build_context_artifacts}/${product}-${version}_${profile}.zip -d ${build_context_artifacts} ; then
    echo "Failed to extract the profile optimized product distribution!"
    exit 1
fi

if ! rm ${build_context_artifacts}/${product}-${version}_${profile}.zip ; then
    echo "Failed to remove the profile optimized product distribution!"
    exit 1
fi

echo "Extraction of the optimized product distribution successful!!!"

if [ ! -f ${build_context_artifacts}/mysql-connector-java-*-bin.jar* ]; then
    echo "MySQL JDBC Connector not found!"
    exit 1
fi

if ! docker build -t ${product}-${profile}:${version} ${dockerfile_home} ; then
    echo "Failed to build the Docker image ${product}-${profile}:${version}!"
    exit 1
fi

echo "Docker image ${product}-${profile}:${version} build successful!!!"
