FROM alpine:3.6
LABEL maintainer="Abel Perez <abelperezok@gmail.com>"

# Install packages needed to build
RUN apk add --update --no-cache \
    bash \
    ca-certificates \
    curl \
    python \
    py-pip \
    wget \
  && pip install --upgrade pip \
  && pip install -U awscli

# Install hugo.
ARG HUGO_VERSION=0.40.3
ARG HUGO_SHA256=a3913a5aca407b8badaba30dec764c2615fc59dd0e73129ddaf5cca0e75a475f

# Rember sha256sum (and md5sum) expect 2 spaces in front of the filename on alpine...
RUN curl -Ls https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
       -o /tmp/hugo.tar.gz \
  && echo "${HUGO_SHA256}  /tmp/hugo.tar.gz" | sha256sum -c - \
  && tar xf /tmp/hugo.tar.gz -C /tmp \
  && mv /tmp/hugo /usr/bin/hugo \
  && rm -rf /tmp/hugo*

# Install Node & NPM
RUN apk add --update nodejs nodejs-npm

# Install Gulp
RUN npm i -g gulp
