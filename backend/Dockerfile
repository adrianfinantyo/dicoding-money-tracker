FROM node:16

WORKDIR /usr/src/app

COPY . /usr/src/app

RUN npm install

ENV PORT=8080

EXPOSE 8080

CMD [ "node", "app.js" ]