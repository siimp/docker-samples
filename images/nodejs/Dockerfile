FROM node:17.3.0-alpine 

LABEL author=Siim

ENV NODE_ENV=production
ENV PORT=3000

WORKDIR /var/www

# to reduce build times. npm install is run only when package.json or package-lock.json is changed
COPY package.json package-lock.json /var/www/
RUN npm install

COPY index.js /var/www/
RUN npm install

EXPOSE $PORT

ENTRYPOINT [ "npm", "run", "start" ]