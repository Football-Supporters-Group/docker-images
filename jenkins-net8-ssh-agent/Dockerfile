FROM jenkins/ssh-agent:alpine-jdk17 as agent

COPY ./scripts/prep-docker.sh prep-docker.sh
COPY ./scripts/wrap-powershell.sh wrap-powershell.sh
RUN ls .

#Dependencies
RUN apk add --no-cache \
    docker gpg gpg-agent tar ca-certificates-bundle \
    libgcc libssl3 libstdc++ zlib libgdiplus icu-libs \
    less ncurses-terminfo-base krb5-libs libintl \
    tzdata userspace-rcu zlib curl
RUN apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache \
    lttng-ust

#Final Prep
RUN adduser jenkins docker
RUN chmod +x ./prep-docker.sh
RUN chmod +x ./wrap-powershell.sh

#Dotnet 8
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh \
    && chmod +x ./dotnet-install.sh \
    && ./dotnet-install.sh --channel 8.0 \
    && echo 'export DOTNET_ROOT=/root/.dotnet' >> ~/.bashrc \
    && echo 'export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools' >> ~/.bashrc

#Powershell
RUN curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.4.5/powershell-7.4.5-linux-musl-x64.tar.gz -o /tmp/powershell.tar.gz
RUN mkdir -p /opt/microsoft/powershell/7 \
    && tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7 \
    && chmod +x /opt/microsoft/powershell/7/pwsh \
    && ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh \
    && echo 'export PSHOME=/opt/microsoft/powershell/7' >> ~/.bashrc\
    && echo 'export PATH=$PATH:$PSHOME' >> ~/.bashrc

RUN cp ~/.bashrc /home/jenkins/.bashrc

VOLUME /var/run/docker.sock

ENTRYPOINT ["/bin/bash", "-c", "prep-docker.sh ; setup-sshd"]