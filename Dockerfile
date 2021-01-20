# Stage 0 - Building Frontend Assets
FROM node:12.16.3-alpine as build
# Create working directory 
WORKDIR /app
# Copy package.json
COPY package*.json ./
RUN npm install
# Copy node_modeules into working directory 
COPY . .
# Build for production 
RUN npm run build

# Stage 1 -  Serving Frontend Assets
FROM fholzer/nginx-brotli:v1.12.2
# Create working directory
WORKDIR /etc/nginx
# Add nginx configuration to container 
ADD nginx.conf /etc/nginx/nginx.conf
# Copy our build assets into our container
COPY --from=build /app/build /usr/share/nginx/html
# Expose our container port
EXPOSE 443
# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
