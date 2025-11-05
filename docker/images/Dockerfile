FROM python:3.12-slim

# DL3008 & DL3009 Resuelto: Se combinan update, install y cleanup
# en una sola instrucción RUN para reducir el tamaño de la imagen y limpiar caché.
RUN apt-get update \
    && apt-get install -y --no-install-recommends mariadb-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
