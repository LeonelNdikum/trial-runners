
FROM nginx:alpine

# ── Image metadata ───────────────────────────────────────────────
LABEL maintainer="Leonel Ndikum"
LABEL org="Zsoftly Team"
LABEL project="Project 2 — Dockerized Static Website"
LABEL version="1.0.0"
LABEL description="Static HTML/CSS website served by Nginx inside Docker"

# ── Remove default Nginx welcome page ───────────────────────────
RUN rm -rf /usr/share/nginx/html/*

# ── Copy website source files into Nginx web root ───────────────
COPY website/index.html /usr/share/nginx/html/index.html
COPY website/style.css  /usr/share/nginx/html/style.css

# ── Copy custom Nginx configuration ─────────────────────────────
COPY nginx.conf /etc/nginx/conf.d/default.conf

# ── Expose HTTP port ─────────────────────────────────────────────
EXPOSE 80

# ── Health check ─────────────────────────────────────────────────
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost/ || exit 1

# ── Start Nginx in foreground ────────────────────────────────────
CMD ["nginx", "-g", "daemon off;"]
