# Use a lightweight but compatible Python base image
FROM python:3.10-slim-buster

# Set working directory
WORKDIR /app

# Install system dependencies needed for Superset and PostgreSQL client
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gcc \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install wheel for faster installs
RUN pip install --upgrade pip wheel setuptools

# Install Superset with pre-built wheels to avoid building pandas from source
RUN pip install --no-cache-dir apache-superset

# Expose port 8088 (Superset's default)
EXPOSE 8088

# Initialize and start Superset
CMD ["bash", "-c", "\
    superset db upgrade && \
    superset fab create-admin --username admin --firstname Superset --lastname Admin --email admin@superset.com --password admin && \
    superset init && \
    superset run -p 8088 -h 0.0.0.0 \
"]

