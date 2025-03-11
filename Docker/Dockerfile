# Stage 1: Build
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Final
FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY . .
CMD ["python", "app.py"]

# Stage 1: Build  
FROM maven:3.9.1-eclipse-temurin-17 AS builder  
WORKDIR /app  
COPY pom.xml .  
COPY src ./src  
RUN mvn clean package -DskipTests  

# Stage 2: Final  
FROM eclipse-temurin:17-jdk  
WORKDIR /app  
COPY --from=builder /app/target/*.jar app.jar  
CMD ["java", "-jar", "app.jar"]  



# Stage 1: Build
FROM node:20 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .

# Stage 2: Final
FROM node:20
WORKDIR /app
COPY --from=builder /app .
ENTRYPOINT ["node", "app.js"]
