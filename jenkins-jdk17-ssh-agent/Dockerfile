FROM jenkins/ssh-agent:alpine-jdk17 as agent
COPY install-mvn.sh install-mvn.sh

RUN apk add --no-cache docker gpg gpg-agent tar
RUN adduser jenkins docker
RUN chmod +x ./install-mvn.sh
RUN ./install-mvn.sh

VOLUME /var/run/docker.sock
RUN chmod 666 /var/run/docker.sock

ENTRYPOINT ["setup-sshd"]