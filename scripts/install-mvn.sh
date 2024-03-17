##!/bin/sh
mkdir -p /usr/local/mvn
mkdir -p /tmp/downloads
cd /tmp/downloads
wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz -O /tmp/downloads/apache-maven-3.9.6-bin.tar.gz
tar -xvzf /tmp/downloads/apache-maven-3.9.6-bin.tar.gz -C /usr/local/mvn/
ln -s /usr/local/mvn/apache-maven-3.9.6/bin/mvn /usr/bin/mvn
rm /tmp/downloads/apache-maven-3.9.6-bin.tar.gz
rm /tmp/downloads -r