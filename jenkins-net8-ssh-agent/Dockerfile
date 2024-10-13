FROM jenkins/ssh-agent:alpine-jdk17 as agent

COPY ./scripts/*.sh .
RUN ls .

RUN apk add --no-cache docker gpg gpg-agent tar ca-certificates-bundle libgcc libssl3 libstdc++ zlib libgdiplus
RUN adduser jenkins docker
RUN chmod +x ./prep-docker.sh
RUN chmod +x ./wrap-powershell.sh

RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh \
    && chmod +x ./dotnet-install.sh \
    && ./dotnet-install.sh --channel 8.0 \
    && echo 'export DOTNET_ROOT=$HOME/.dotnet' >> ~/.bashrc \
    && echo 'export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools' >> ~/.bashrc

VOLUME /var/run/docker.sock

ENTRYPOINT ["/bin/bash", "-c", "prep-docker.sh ; setup-sshd"]