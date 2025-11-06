FROM python:3.12-slim

# DL3008 & DL3009 Resuelto: Se combinan update, install y cleanup en una sola instrucción RUN.
RUN apt-get update \
    && apt-get install -y --no-install-recommends mariadb-client \
    && apt-get install -y --no-install-recommends gcc libc-dev python3-dev libffi-dev \
    && apt-get install -y --no-install-recommends curl \
    && apt-get install -y --no-install-recommends bash \
    && apt-get install -y --no-install-recommends openrc \
    && apt-get install -y --no-install-recommends build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* # hadolint ignore=DL3008

# Set the working directory in the container to /app
WORKDIR /app

# Copy application files
COPY app/ ./app
COPY core/ ./core
COPY migrations/ ./migrations

# Copy requirements.txt into the working directory /app
COPY requirements.txt .

# Removes cache at the build stage
RUN find . -type d -name "__pycache__" -exec rm -r {} + && \
    find . -type f -name "*.pyc" -exec rm -f {} +

# CRÍTICO: Copiar el entrypoint de Render y darle permisos de ejecución
COPY scripts/render_entrypoint.sh /app/render_entrypoint.sh
RUN chmod +x /app/render_entrypoint.sh

# Copiar el script de espera de base de datos y darle permisos de ejecución
COPY scripts/wait-for-db.sh /app/scripts/wait-for-db.sh
RUN chmod +x /app/scripts/wait-for-db.sh

# Create the .moduleignore file with the module 'webhook' inside
RUN echo "webhook" > /app/.moduleignore

# Update pip
RUN pip install --no-cache-dir --upgrade pip

# Install any needed packages specified in requirements.txt (incluyendo gunicorn)
RUN pip install -r requirements.txt

# Expose port 80 (Gunicorn usará este puerto en el entrypoint)
EXPOSE 80

# Command to run the application (inicia las migraciones y luego Gunicorn)
CMD ["./render_entrypoint.sh"]