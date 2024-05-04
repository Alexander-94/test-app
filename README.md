# Test Spring Boot 3 app + Docker

docker build -t app .

docker run -dp 127.0.0.1:8080:8080 app
