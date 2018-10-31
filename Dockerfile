FROM node:carbon-alpine

RUN apk update && apk upgrade && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache \
      openjdk8 \
      chromium@edge \
      nss@edge \
      freetype@edge \
      harfbuzz@edge

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV PUPPETEER_EXECUTABLE_PATH "/usr/bin/chromium-browser"
RUN yarn add puppeteer

RUN addgroup -S pptruser && adduser -S -g pptruser pptruser \
    && mkdir -p /home/pptruser/Downloads \
    && chown -R pptruser:pptruser /home/pptruser


RUN  mkdir /jenkins && chmod 777  /jenkins

RUN  apk add --no-cache \
    git \
    bash

# Run everything after as non-privileged user.
USER pptruser


