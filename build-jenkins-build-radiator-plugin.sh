#!/bin/bash
read -r -d '' BUILD_SCRIPT <<- EndOfBuildScript
git clone https://github.com/jan-molak/jenkins-build-monitor-plugin.git
cd jenkins-build-monitor-plugin
#mvn package
mkdir -p target
EndOfBuildScript

echo Running build. Please wait. To see the output please run docker logs -f <id>

id=$(docker run -i sirkkalap/jenkins-swarm-slave-nlm /bin/bash -c "$BUILD_SCRIPT")

mkdir -p jenkins-build-monitor-plugin
docker cp $id:/home/jenkins-slave/jenkins-build-monitor-plugin/target jenkins-build-monitor-plugin
docker stop $id
docker rm $id

