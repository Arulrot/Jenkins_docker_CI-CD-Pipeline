# Use the official Nginx image
FROM nginx:alpine

# Copy the index.html file to the Nginx web directory
COPY index.html /usr/share/nginx/html/index.html
