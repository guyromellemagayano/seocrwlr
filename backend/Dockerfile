FROM python:3.12.5 AS base
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    postgresql-client \
    postgresql-server-dev-all \
    build-essential \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Ensure docker.dev.sh is executable
RUN chmod +x ./docker.dev.sh
EXPOSE 8000

FROM base AS dev
COPY requirements.dev.txt .
RUN pip install --no-cache-dir -r requirements.dev.txt

FROM base AS prod
COPY requirements.prod.txt .
RUN pip install --no-cache-dir -r requirements.prod.txt

# Collect static files
RUN ENV=production ./manage.py collectstatic --no-input

# Use gunicorn for production
CMD gunicorn server.wsgi:application --bind 0.0.0.0:8000 --workers=2 --threads=2 --access-logfile "-" --keep-alive 65
