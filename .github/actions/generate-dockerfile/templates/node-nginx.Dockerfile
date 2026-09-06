ARG NODE_VERSION=22


# BUILD
FROM node:${NODE_VERSION}-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

RUN npm run build

# RUNTIME
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/dist/ /usr/share/nginx/html/

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]