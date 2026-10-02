FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod download
RUN cd app/teamgram-server && go build -o /main

FROM alpine:latest
WORKDIR /
COPY --from=builder /main /main
EXPOSE 8080
CMD ["/main"]

