FROM golang:latest as mod
LABEL stage=mod
ENV GOPROXY https://goproxy.cn
WORKDIR /usr/src/app/

COPY go.mod ./
COPY go.sum ./
RUN go mod download

FROM mod as builder
LABEL stage=intermediate
COPY ./ ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./bin/app -tags static -ldflags '-s -w' ./main.go

FROM scratch
WORKDIR /usr/src/app/
COPY --from=builder /usr/src/app/bin/app ./
EXPOSE 80
CMD ["./app"]
