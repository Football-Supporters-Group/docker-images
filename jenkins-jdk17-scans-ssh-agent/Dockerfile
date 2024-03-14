FROM jenkins/ssh-agent:alpine-jdk17 as agent
COPY install-mvn.sh install-mvn.sh

RUN apk add --no-cache docker gpg gpg-agent tar
RUN adduser jenkins docker
RUN chmod +x ./install-mvn.sh
RUN ./install-mvn.sh
RUN sh curl -sSfL https://raw.githubusercontent.com/docker/scout-cli/main/install.sh | sh -s -- -b /usr/local/bin

VOLUME /var/run/docker.sock

ENTRYPOINT ["/bin/bash", "-c", "setup-sshd && chmod 666 /var/run/docker.sock"]