FROM golang:1.24-alpine AS builder
RUN apk add --no-cache git make
WORKDIR /app
COPY . .
RUN go mod download
# Собираем все бинарники одной командой make
RUN make

FROM alpine:latest
RUN apk add --no-cache bash
WORKDIR /app
COPY --from=builder /app/teamgramd/bin /app/teamgramd/bin
EXPOSE 8080
# Запускаем скрипт, который включит сразу все микросерверы внутри контейнера
CMD ["bash", "/app/teamgramd/bin/runall2.sh"]
