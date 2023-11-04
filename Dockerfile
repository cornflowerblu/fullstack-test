FROM node:15.5.1-alpine as builder

WORKDIR /app

COPY package*.json /app
RUN npm ci

COPY . /app
RUN npm run build

FROM node:15.5.1-alpine as production
WORKDIR /build

COPY --from=builder /app/build .
RUN npm i -g http-server

CMD ["http-server", "."]