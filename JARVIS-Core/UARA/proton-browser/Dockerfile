FROM mcr.microsoft.com/playwright/python:v1.48.0-jammy
RUN apt-get update && apt-get install -y --no-install-recommends xvfb x11vnc novnc websockify supervisor xauth x11-utils caddy && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir playwright==1.48.0
WORKDIR /app
COPY . .
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
