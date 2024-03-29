
FROM node:16-alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm i
COPY . .
ENV API_PORT=${API_PORT}
EXPOSE ${API_PORT}
CMD [ "npm", "start" ]
