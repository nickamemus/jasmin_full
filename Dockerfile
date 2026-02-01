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
WORKDIR /opt/jasmin

# -------------------------
# Clone Jasmin source
# -------------------------
RUN git clone https://github.com/jookies/jasmin.git /opt/jasmin

# -------------------------
# Install Python dependencies
# -------------------------
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -r requirements_extra.txt

# -------------------------
# Add Jasmin bin to PATH
# -------------------------
ENV PATH="/opt/jasmin/bin:${PATH}"

# -------------------------
# Copy supervisor config
# -------------------------
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# -------------------------
# Copy optional startup script
# -------------------------
# This can create users, routes, etc.
COPY startup.sh /opt/jasmin-scripts/startup.sh
RUN chmod +x /opt/jasmin-scripts/startup.sh

# -------------------------
# Expose SMPP and HTTP ports
# -------------------------
# SMPP ports
EXPOSE 2775 2776
# HTTP API ports
EXPOSE 1400 1401

# -------------------------
# Volumes for persistence
# -------------------------
VOLUME ["/etc/jasmin", "/var/log/jasmin"]

# -------------------------
# Entrypoint
# -------------------------
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
