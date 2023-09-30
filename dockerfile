FROM node:18-alpine as builder
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
RUN npm run build

FROM nginx:stable-alpine as production
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
