FROM mcr.microsoft.com/dotnet/aspnet:8.0 as base


FROM mcr.microsoft.com/dotnet/sdk:8.0 as build
COPY --from=base /usr/share/dotnet /usr/share/dotnet


FROM jenkins/ssh-agent:alpine-jdk17 as agent
COPY --from=build /usr/share/dotnet /usr/share/dotnet
COPY --from=build /usr/bin/pwsh /usr/bin/pwsh
RUN ln -s /usr/share/powershell/pwsh /usr/bin/pwsh \
    && chmod 755 /usr/share/powershell/pwsh
COPY ./scripts/prep-docker.sh prep-docker.sh

RUN apk add --no-cache docker gpg gpg-agent tar
RUN adduser jenkins docker
RUN chmod +x ./prep-docker.sh

VOLUME /var/run/docker.sock

ENTRYPOINT ["/bin/bash", "-c", "prep-docker.sh ; setup-sshd"]