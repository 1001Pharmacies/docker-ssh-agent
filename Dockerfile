# Docker Image for SSH agent container
#
FROM alpine:3.4

MAINTAINER Andreas Urbanski <urbanski.andreas@gmail.com>

# Install dependencies
RUN apk add --no-cache \
	bash \
	openssh \
	socat \
	&& rm -rf /var/cache/apk/*

# Copy entrypoint script to container
COPY docker-entrypoint.sh /docker-entrypoint.sh

# Setup environment variables; export SSH_AUTH_SOCK from socket directory
ENV SOCKET_DIR /.ssh-agent
ENV SSH_AUTH_SOCK ${SOCKET_DIR}/socket
ENV SSH_AUTH_PROXY_SOCK ${SOCKET_DIR}/proxy-socket

VOLUME ${SOCKET_DIR}

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["ssh-agent"]
