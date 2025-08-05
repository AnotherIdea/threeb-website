# Multi-stage build pour optimiser la taille
FROM nginx:alpine

# Copier tous les fichiers du site depuis le dossier site/
COPY site/ /usr/share/nginx/html/

# Configuration Nginx optimisée pour SEO et performance
COPY <<EOF /etc/nginx/conf.d/default.conf
server {
    listen 80;
    server_name _;
    root /usr/share/nginx/html;
    index index.html;

    # Compression gzip
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

    # Cache headers pour les assets statiques
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Headers de sécurité
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;

    # Route principale
    location / {
        try_files \$uri \$uri/ /index.html;
    }

    # Sitemap et robots
    location = /sitemap.xml {
        add_header Content-Type application/xml;
    }

    location = /robots.txt {
        add_header Content-Type text/plain;
    }
}
EOF

# Exposition du port 80
EXPOSE 80

# Labels pour metadata
LABEL maintainer="ThreeB <contact@threeb.fr>"
LABEL description="ThreeB website - DevOps & SRE expertise"
LABEL version="1.0"

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Démarrage de Nginx
CMD ["nginx", "-g", "daemon off;"]