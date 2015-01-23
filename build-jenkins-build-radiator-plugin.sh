#!/bin/bash
read -r -d '' BUILD_SCRIPT <<- EndOfBuildScript
git clone https://github.com/jan-molak/jenkins-build-monitor-plugin.git
cd jenkins-build-monitor-plugin
mvn package
EndOfBuildScript

id=$(docker run -i sirkkalap/jenkins-swarm-slave-nlm /bin/bash -c 1>&2 "$BUILD_SCRIPT")

mkdir -p jenkins-build-monitor-plugin
docker cp $id:/home/jenkins-slave/jenkins-build-monitor-plugin/target jenkins-build-monitor-plugin

docker rm -f $id

