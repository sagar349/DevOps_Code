# Multi-stage Dockerfile for Python and Java applications

###################
# PYTHON BUILD STAGE
###################
FROM python:3.11-slim AS python-builder

WORKDIR /app

# Copy Python requirements file
COPY requirements.txt .

# Install build dependencies and Python packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc python3-dev && \
    pip install --no-cache-dir wheel && \
    pip wheel --no-cache-dir --wheel-dir=/app/wheels -r requirements.txt && \
    rm -rf /var/lib/apt/lists/*

###################
# PYTHON FINAL STAGE
###################
FROM python:3.11-slim AS python-final

WORKDIR /app

# Copy wheels from builder stage
COPY --from=python-builder /app/wheels /wheels

# Install Python packages from wheels
RUN pip install --no-cache-dir --no-index --find-links=/wheels /wheels/* && \
    rm -rf /wheels

# Copy Python application code
COPY app/ .

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Run the Python application
CMD ["python", "main.py"]

###################
# JAVA BUILD STAGE
###################
FROM maven:3.9-eclipse-temurin-17 AS java-builder

WORKDIR /build

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code and build the application
COPY src/ ./src/
RUN mvn package -DskipTests

###################
# JAVA FINAL STAGE
###################
FROM eclipse-temurin:17-jre-jammy AS java-final

WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=java-builder /build/target/*.jar app.jar

# Set environment variables
ENV JAVA_OPTS="-Xms512m -Xmx1024m"

# Run the Java application
CMD ["java", "-jar", "app.jar"]

###################
# USAGE INSTRUCTIONS
###################
# To build and run the Python application:
# docker build --target python-final -t my-python-app .
# docker run -it --rm my-python-app
#
# To build and run the Java application:
# docker build --target java-final -t my-java-app .
# docker run -it --rm my-java-app