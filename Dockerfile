# Use official alpine
FROM alpine

# Install apps
RUN apk update && apk add --no-cache wget bash build-base autoconf automake libtool

# Copy source and customized files
COPY socat-1.7.3.2.tar.gz /tmp
RUN tar -xzf /tmp/socat-1.7.3.2.tar.gz -C /tmp
COPY xio-ip4.c xio-proxy.c /tmp/socat-1.7.3.2

# Copy build-socatup script
COPY build-socat.sh /build-socat.sh
RUN chmod +x /build-socat.sh

# Use custom build-socatup script
CMD ["/build-socat.sh"]
