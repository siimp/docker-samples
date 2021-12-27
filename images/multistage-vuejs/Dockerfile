FROM node:16.13.1-alpine3.12 AS test_and_build

COPY . /app

WORKDIR /app

RUN npm install
RUN npm run lint
RUN npm run test:unit
RUN npm run build



FROM nginx:1.21.4-alpine AS final

COPY --from=test_and_build /app/dist /usr/share/nginx/html

