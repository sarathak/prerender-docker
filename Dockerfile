FROM node:16-alpine

MAINTAINER Sarath AK <aksarath@gmail.com>
RUN apk add --no-cache ca-certificates && \
    apk add chromium=91.0.4472.77-r0 --no-cache --repository http://nl.alpinelinux.org/alpine/edge/community

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .

ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

RUN addgroup -S prerender && adduser -S -g prerender prerender

USER prerender
ENV DISPLAY :99.0
CMD [ "npm", "start" ]
#CMD [ "google-chrome","--headless","--no-sandbox", ]
EXPOSE 3000