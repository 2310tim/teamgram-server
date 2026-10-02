FROM golang:1.24-alpine AS builder
# Добавили bash, чтобы make не ругался на отсутствие /bin/bash
RUN apk add --no-cache git make bash
WORKDIR /app
COPY . .
RUN go mod download
RUN make

FROM alpine:latest
RUN apk add --no-cache bash
WORKDIR /app
COPY --from=builder /app/teamgramd/bin /app/teamgramd/bin
EXPOSE 8080
CMD ["bash", "/app/teamgramd/bin/runall2.sh"]
