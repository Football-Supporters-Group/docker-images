# FROM mcr.microsoft.com/dotnet/aspnet:8.0 as base


FROM mcr.microsoft.com/dotnet/sdk:8.0 as build
# COPY --from=base ["/usr/share/dotnet", "/usr/share/dotnet"]
# COPY --from=base ["/dotnet-symlink", "/usr/bin"]


FROM jenkins/ssh-agent:alpine-jdk17 as agent
COPY --from=build ["/usr/share/dotnet", "/usr/share/dotnet"]
COPY --from=build ["/dotnet-symlink", "/usr/bin"]
COPY --from=build ["/usr/share/powershell/pwsh", "/usr/share/powershell/pwsh"]

# COPY --from=build /usr/share/dotnet /usr/share/dotnet

COPY ./scripts/*.sh .
RUN ls .

RUN apk add --no-cache docker gpg gpg-agent tar
RUN adduser jenkins docker
RUN chmod +x ./prep-docker.sh
RUN chmod +x ./wrap-powershell.sh

VOLUME /var/run/docker.sock

ENTRYPOINT ["/bin/bash", "-c", "prep-docker.sh ; wrap-powershell.sh ; setup-sshd"]