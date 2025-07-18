# Optimized production image for FX Lessons
FROM nginx:alpine

# Install necessary packages
RUN apk add --no-cache curl

# Create optimized nginx configuration
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
    try_files $uri $uri/ /index.html; \
    } \
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ { \
    expires 1y; \
    add_header Cache-Control "public, immutable"; \
    } \
    gzip on; \
    gzip_vary on; \
    gzip_min_length 1024; \
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/xml+rss application/json; \
    }' > /etc/nginx/conf.d/default.conf

# Set working directory
WORKDIR /usr/share/nginx/html

# Copy project files
COPY . .

# Create fx_lessons/ambient_occlusion directory structure
RUN mkdir -p fx_lessons/ambient_occlusion

# Move project files to ambient_occlusion directory
RUN mv fx_lessons/ambient_occlusion/index.html fx_lessons/ambient_occlusion/ && \
    mv fx_lessons/ambient_occlusion/README.md fx_lessons/ambient_occlusion/ 2>/dev/null || true && \
    mv fx_lessons/ambient_occlusion/package.json fx_lessons/ambient_occlusion/ 2>/dev/null || true && \
    mv fx_lessons/ambient_occlusion/.vscode fx_lessons/ambient_occlusion/ 2>/dev/null || true

# Create optimized root index.html with redirect
RUN echo '<!DOCTYPE html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>FX Lessons - Three.js Visual Effects</title><style>body{font-family:Arial,sans-serif;background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);margin:0;display:flex;justify-content:center;align-items:center;min-height:100vh;color:#fff}.container{text-align:center;background:rgba(255,255,255,0.1);padding:2rem;border-radius:1rem;backdrop-filter:blur(10px)}h1{margin:0 0 1rem 0;font-size:2.5rem}.btn{display:inline-block;background:#fff;color:#667eea;padding:1rem 2rem;text-decoration:none;border-radius:0.5rem;font-weight:bold;transition:transform 0.3s ease}.btn:hover{transform:translateY(-2px)}.features{margin:2rem 0;text-align:left}.features h3{margin:0 0 1rem 0}.features ul{margin:0;padding-left:1.5rem}</style></head><body><div class="container"><h1>🎨 FX Lessons</h1><p>Interactive Three.js Visual Effects Collection</p><div class="features"><h3>🌟 Features:</h3><ul><li>Ambient Occlusion (SSAO) Effects</li><li>Particle Wave Systems</li><li>Interactive 3D Controls</li><li>Real-time Lighting</li><li>Multiple Input Methods</li></ul></div><a href="/fx_lessons/ambient_occlusion/" class="btn">🚀 Start Learning</a></div></body></html>' > index.html

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]