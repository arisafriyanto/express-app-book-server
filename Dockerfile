FROM node:20-alpine as build-image

WORKDIR /usr/src/app

COPY package*.json ./
 
COPY tsconfig.json ./

COPY ./ ./

RUN npm ci

RUN npx tsc -p .


FROM node:20-alpine

WORKDIR /usr/src/app

COPY package*.json ./

COPY --from=build-image ./usr/src/app/dist ./dist

RUN npm ci --production

COPY . .

EXPOSE 8000

CMD ["node", "dist/server.js"]


# FROM node:20-alpine
# WORKDIR /usr/src/app
# COPY package*.json ./
# COPY tsconfig.json ./
# COPY . .
# RUN npm ci
# RUN npx tsc -p .
# EXPOSE 3000
# CMD ["node", "dist/server.js"]