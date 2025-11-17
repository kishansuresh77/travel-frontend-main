# Step 1: Build stage
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Ensure build works
RUN npm run build

# Step 2: Production stage
FROM nginx:alpine

# Replace default NGINX content
RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/dist /usr/share/nginx/html  # for Vite
# COPY --from=build /app/build /usr/share/nginx/html  # for Create React App

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
