ARG NGINX_VERSION=1.27
FROM nginx:${NGINX_VERSION}-alpine

RUN apk update && \
  apk upgrade && \
  apk --update add logrotate && \
  apk add --no-cache \
    bash \
    curl \
    openssl

# Add www-data user
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

# Copy main config
COPY nginx.conf /etc/nginx/

# Setup Logrotate
COPY nginx.logrotate /etc/logrotate.d/nginx
RUN chmod 644 /etc/logrotate.d/nginx

# Setup timezone
ARG TZ=UTC
ENV TZ=${TZ}

RUN cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} > /etc/timezone

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

COPY ./startup.sh /opt/

CMD [ "/bin/bash", "/opt/startup.sh" ]

EXPOSE 80 443

