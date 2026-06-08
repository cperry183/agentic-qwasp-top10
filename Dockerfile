# Use a slim, secure base image
FROM python:3.11-slim

# Set environment variables to prevent Python from writing .pyc files and buffering output
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
RUN useradd -m appuser
USER appuser
# Set the working directory inside the container
WORKDIR /app

# Copy dependency files first to leverage Docker layer caching
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the necessary port (e.g., 8000, 8080)
EXPOSE 8000

# Command to run the application
# Replace 'main.py' with your entry point script
CMD ["python", "main.py"]
