### STAGE 1: Build ###
FROM node:16-alpine AS node
WORKDIR /app
COPY . .
RUN yarn install
ENV REACT_APP_BACKEND http://13.68.217.46:5000
RUN yarn build

### STAGE 2: Run ###
FROM nginx:1.21.6-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=node /app/build/ /usr/share/nginx/html
EXPOSE 3000

#EJEMPLO SINGLE STAGE - YA TIENE QUE ESTAR REALIZADO EL BUILD
#FROM nginx:1.21.6-alpine
#COPY nginx.conf /etc/nginx/nginx.conf
#COPY ./build/ /usr/share/nginx/html