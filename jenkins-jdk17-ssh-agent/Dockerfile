FROM jenkins/ssh-agent:alpine-jdk17 as agent
COPY install-mvn.sh install-mvn.sh

#ENV JAVA_HOME="/opt/java/openjdk/bin/java"
#RUN export JAVA_HOME

RUN apk add --no-cache docker gpg gpg-agent tar
RUN adduser jenkins docker
RUN chmod +x ./install-mvn.sh
RUN ./install-mvn.sh

ENTRYPOINT ["setup-sshd"]