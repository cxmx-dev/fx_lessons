# Use nginx alpine as base image
FROM nginx:alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Copy project files
COPY . .

# Create fx_lessons/ambient_occlusion directory structure
RUN mkdir -p /usr/share/nginx/html/fx_lessons/ambient_occlusion

# Move all project files to the ambient_occlusion directory
RUN mv index.html fx_lessons/ambient_occlusion/ && \
    mv README.md fx_lessons/ambient_occlusion/ && \
    mv package.json fx_lessons/ambient_occlusion/ && \
    mv .vscode fx_lessons/ambient_occlusion/ 2>/dev/null || true

# Create a simple index.html in root that redirects to the project
RUN echo '<!DOCTYPE html><html><head><meta http-equiv="refresh" content="0; url=/fx_lessons/ambient_occlusion/"></head><body><p>Redirecting to <a href="/fx_lessons/ambient_occlusion/">Three.js Ambient Occlusion Scene</a></p></body></html>' > index.html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"] 