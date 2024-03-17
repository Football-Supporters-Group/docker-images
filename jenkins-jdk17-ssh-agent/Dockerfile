FROM jenkins/ssh-agent:alpine-jdk17 as agent
COPY ./scripts/install-mvn.sh install-mvn.sh
COPY ./scripts/prep-docker.sh prep-docker.sh

RUN apk add --no-cache docker gpg gpg-agent tar
RUN adduser jenkins docker
RUN chmod +x ./install-mvn.sh
RUN chmod +x ./prep-docker.sh
RUN ./install-mvn.sh

VOLUME /var/run/docker.sock

ENTRYPOINT ["/bin/bash", "-c", "./prep-docker.sh && setup-sshd"]