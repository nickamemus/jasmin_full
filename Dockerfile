FROM python:3.12-slim

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libpq-dev \
    sqlite3 \
    supervisor \
    && rm -rf /var/lib/apt/lists/*
