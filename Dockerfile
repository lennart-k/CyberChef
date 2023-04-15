FROM node:16-alpine as build

# RUN apk add build-base musl-dev libffi-dev openssl-dev

WORKDIR /usr/src/app
# COPY package*.json ./
# COPY Gruntfile.js .
# Unfortunately, some things are already done on npm install, I don't want to dig into it :/
COPY . .
RUN npm install
RUN npm run build


FROM nginx as server
COPY --from=build /usr/src/app/build/prod /usr/share/nginx/html
