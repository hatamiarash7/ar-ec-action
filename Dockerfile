FROM debian:stable-slim

LABEL maintainer="Arash Hatami <hatamiarash7@gmail.com>"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.authors="hatamiarash7"
LABEL org.opencontainers.image.vendor="hatamiarash7"
LABEL org.opencontainers.image.title="ArvanCloud Edge Computing Action"
LABEL org.opencontainers.image.description="Deploy new changes to ArvanCloud Edge Computing"
LABEL org.opencontainers.image.source="https://github.com/hatamiarash7/ar-ec-action"

RUN apt-get update && apt-get install -y \
    curl gpg && \
    curl -fsSL https://repo.arvancloud.ir/apt/gpg.key | gpg --dearmor -o /usr/share/keyrings/arvancloud.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/arvancloud.gpg] https://repo.arvancloud.ir/apt * *" | tee /etc/apt/sources.list.d/arvancloud.list && \
    apt-get update && apt-get install arvan && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]