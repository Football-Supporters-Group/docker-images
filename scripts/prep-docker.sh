##!/bin/sh
su jenkins
chown jenkins /var/run/docker.sock
chmod 666 /var/run/docker.sock
