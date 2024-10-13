FROM mcr.microsoft.com/dotnet/aspnet:8.0 as base


FROM mcr.microsoft.com/dotnet/sdk:8.0 as build
COPY --from=base /usr/share/dotnet /usr/share/dotnet


FROM jenkins/ssh-agent:alpine-jdk17 as agent
COPY --from=build /usr/share/dotnet /usr/share/dotnet
COPY --from=build /usr/bin/pwsh /usr/bin/pwsh
RUN mkdir -p /usr/share/powershell

COPY ./scripts/prep-docker.sh prep-docker.sh
COPY ./scripts/wrap-powershell.sh wrap-powershell.sh

RUN apk add --no-cache docker gpg gpg-agent tar
RUN adduser jenkins docker
RUN chmod +x ./prep-docker.sh
RUN chmod +x ./wrap_powershell.sh

VOLUME /var/run/docker.sock

ENTRYPOINT ["/bin/bash", "-c", "prep-docker.sh ; wrap-powershell.sh ; setup-sshd"]