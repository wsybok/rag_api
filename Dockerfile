FROM python:3.10 AS main

WORKDIR /app

# Install pandoc and netcat
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    pandoc \
    netcat-openbsd \
    libgl1-mesa-glx \  
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Create directory for Google credentials
RUN mkdir -p /app/credentials

# Set default credentials path
ENV GOOGLE_APPLICATION_CREDENTIALS=/app/credentials/google.json

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "main.py"]
