FROM debian:stable-slim

LABEL maintainer="Arash Hatami <hatamiarash7@gmail.com>"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.authors="hatamiarash7"
LABEL org.opencontainers.image.vendor="hatamiarash7"
LABEL org.opencontainers.image.title="ArvanCloud Edge Computing Action"
LABEL org.opencontainers.image.description="Deploy new changes to ArvanCloud Edge Computing"
LABEL org.opencontainers.image.source="https://github.com/hatamiarash7/ar-ec-action"

RUN apt-get update && apt-get install -y \
    wget curl gpg tar && \
    wget -q "https://git.arvancloud.ir/arvancloud/cli/-/releases/v0.3.0/downloads/arvan-cli-0.3.0-linux-amd64.tar.gz" -O - | tar -xz -C /usr/bin/ && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]