# Multi-stage Dockerfile
FROM python:3.8-slim as builder

WORKDIR /app

COPY app.py .

RUN python -m compileall .

# Final image
FROM python:3.8-slim

WORKDIR /app

COPY --from=builder /app .

CMD ["python", "app.py"]
