#!/bin/bash
read -r -d '' BUILD_SCRIPT <<- EndOfBuildScript
git clone https://github.com/jan-molak/jenkins-build-monitor-plugin.git
cd jenkins-build-monitor-plugin
mvn package
EndOfBuildScript

echo Running build. Please wait.

docker run -i --name build-job sirkkalap/jenkins-swarm-slave-nlm /bin/bash -c "$BUILD_SCRIPT"

mkdir -p jenkins-build-monitor-plugin
docker cp build-job:/home/jenkins-slave/jenkins-build-monitor-plugin/target jenkins-build-monitor-plugin
docker stop build-job
docker rm build-job

