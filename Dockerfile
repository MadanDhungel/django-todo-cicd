# Use an official lightweight Python image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Install Django directly (no requirements.txt)
RUN pip install --no-cache-dir django==3.2

# Copy all project files into the container
COPY . .

# Expose port 8000 for the Django development server
EXPOSE 8000

# Run migrations and start the Django server
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]

