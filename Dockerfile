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

# Create directory for Google credentials with proper permissions
RUN mkdir -p /app/api/data && chmod 755 /app/api/data

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "main.py"]
