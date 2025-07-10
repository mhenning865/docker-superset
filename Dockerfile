FROM python:3.10-slim-buster

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gcc \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip wheel setuptools

RUN pip install --no-cache-dir apache-superset

EXPOSE 8088

CMD ["bash", "-c", "\
    export FLASK_APP=superset && \
    superset db upgrade && \
    superset fab create-admin --username admin --firstname Superset --lastname Admin --email admin@superset.com --password admin && \
    superset init && \
    superset run -p 8088 -h 0.0.0.0 \
"]

