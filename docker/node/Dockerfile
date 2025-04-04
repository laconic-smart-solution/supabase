FROM debian:12-slim

ENV DEBIAN_FRONTEND noninteractive

USER root

RUN apt-get update && \
  apt-get upgrade -yqq && \
  apt-get install -yqq curl

ARG PUID=1000
ENV PUID=${PUID}
ARG PGID=1000
ENV PGID=${PGID}

# Add node user
RUN set -xe; \
  groupadd --gid ${PGID} node && \
  useradd \
    --uid ${PUID} \
    --gid ${PGID} \
    --no-log-init \
    --create-home \
    node

RUN set -xe; \
  mkdir -p /var/www && \
  chown -R ${PUID}:${PGID} /var/www

# Add timezone
ARG TZ=UTC
ENV TZ=${TZ}

RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

USER node

ENV HOME=/home/node

WORKDIR /home/node

ENV NVM_DIR=${HOME}/.nvm

# Install NVM
RUN mkdir -p ${NVM_DIR} && \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && \
  . ${NVM_DIR}/nvm.sh

RUN echo '\n\
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" \n\
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \n\
' >> ${HOME}/.bashrc

ARG INSTALL_VERSION=node
ENV INSTALL_VERSION=${INSTALL_VERSION}

RUN set -xe; \
  . ${NVM_DIR}/nvm.sh && \
  nvm install ${INSTALL_VERSION} && \
  nvm use ${INSTALL_VERSION} && \
  curl -fsSL https://get.pnpm.io/install.sh | ENV="$HOME/.bashrc" SHELL="$(which bash)" bash -

USER node

WORKDIR /var/www
