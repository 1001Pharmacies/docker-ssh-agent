# Docker Image for SSH agent container
#
FROM alpine:latest

LABEL maintainer "Yann Autissier <yann.autissier@gmail.com>"

# Install dependencies
RUN apk add --no-cache \
        openssh \
        socat

# Setup environment variables; export SSH_AUTH_SOCK from socket directory
ENV SOCKET_DIR /tmp/ssh-agent
ENV SSH_AUTH_SOCK ${SOCKET_DIR}/socket
ENV SSH_AUTH_PROXY_SOCK ${SOCKET_DIR}/proxy-socket

VOLUME ${SOCKET_DIR}

# Copy entrypoint script to container
COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["ssh-agent"]
