FROM mcr.microsoft.com/dotnet/aspnet:8.0 as base
FROM mcr.microsoft.com/dotnet/sdk:8.0 as build
COPY --from=0 / /
FROM jenkins/ssh-agent:alpine-jdk17 as agent
COPY --from=0 / /
COPY ./scripts/prep-docker.sh prep-docker.sh

RUN apk add --no-cache docker gpg gpg-agent tar
RUN adduser jenkins docker
RUN chmod +x ./prep-docker.sh

VOLUME /var/run/docker.sock

ENTRYPOINT ["/bin/bash", "-c", "prep-docker.sh ; setup-sshd"]