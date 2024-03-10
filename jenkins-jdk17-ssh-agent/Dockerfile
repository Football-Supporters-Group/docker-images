FROM jenkins/ssh-agent:alpine-jdk17 as agent
RUN apk add --no-cache gpg
ENTRYPOINT ["setup-sshd"]