FROM nginx:alpine

LABEL maintainer="Leonel Ndikum"
LABEL org="Zsoftly Team"
LABEL project="Project 2 — Dockerized Static Website"
LABEL version="1.0.0"
LABEL description="Static HTML/CSS website served by Nginx inside Docker"

RUN rm -rf /usr/share/nginx/html/*

COPY website/index.html /usr/share/nginx/html/index.html
COPY website/style.css /usr/share/nginx/html/style.css

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
