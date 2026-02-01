# =========================
# Jasmin Production Dockerfile
# =========================

FROM python:3.12-slim

# -------------------------
# Install OS dependencies
# -------------------------
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libpq-dev \
    supervisor \
    vim \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# -------------------------
# Create directories
# -------------------------
RUN mkdir -p /opt/jasmin /var/log/jasmin /etc/jasmin /opt/jasmin-scripts
WORKDIR /o
