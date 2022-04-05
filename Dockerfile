FROM golang:latest AS builder
WORKDIR /workspace
ENV GO111MODULE=on \
    GOPROXY=https://goproxy.cn,direct

# cache deps before building and copying source so that we don't need to re-download as much
# and so that source changes don't invalidate our downloaded layer
COPY go.mod go.mod
COPY go.sum go.sum
RUN go mod download

COPY .. .
RUN go build -o main

FROM alpine:3.12
COPY --from=builder /workspace /main
RUN chmod 777 /main
ENV TZ=Asia/Shanghai
EXPOSE 8000
ENTRYPOINT ["/main"]
