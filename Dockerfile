# Usa una imagen base de Python ligera (slim)
FROM python:3.12-slim

# Configuraciones de entorno estándar de Python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Crea el directorio de trabajo dentro del contenedor
WORKDIR /app

# 1. Instalar dependencias
# Copia solo el archivo de requerimientos para aprovechar el cache de Docker.
COPY requirements.txt .

# Instala las dependencias de producción
RUN pip install --no-cache-dir -r requirements.txt

# 2. Copiar el código de la aplicación
# Copia el resto del código fuente (incluyendo el módulo 'app')
COPY . .

# 3. Exponer el puerto
# Reemplaza 8000 si tu aplicación usa otro puerto (ej. 5000 para Flask)
EXPOSE 8000

# 4. Comando de inicio (Ajusta esto al comando que realmente inicia UVLHub)
# Ejemplo común para una app web Python con Gunicorn:
# CMD ["gunicorn", "wsgi:app", "--bind", "0.0.0.0:8000"]
# Si usa Flask directamente (solo para desarrollo/pruebas):
CMD ["python", "app.py"]
