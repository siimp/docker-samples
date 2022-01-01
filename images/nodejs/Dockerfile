FROM node:17.3.0-alpine 

LABEL author=Siim

ENV NODE_ENV=production
ENV PORT=3000

COPY package.json index.js /var/www/
WORKDIR /var/www

RUN npm install

EXPOSE $PORT

ENTRYPOINT [ "npm", "run", "start" ]