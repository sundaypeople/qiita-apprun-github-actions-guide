FROM golang:latest AS builder

WORKDIR /usr/src/app

COPY go.mod ./
COPY ./ ./

RUN CGO_ENABLED=0 go build -v -o /usr/local/bin/app ./...

FROM gcr.io/distroless/static:nonroot
COPY --from=builder /usr/local/bin/app ./
CMD ["./app"]
EXPOSE 8080