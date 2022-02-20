# go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26
# go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1 
TARGET ?= .

clean:
	rm -rf v1 

.PHONY: pb clean  log secret queue
pb: clean fmt  log secret config queue 


log:
	mkdir -p ${TARGET}/v1/log
	protoc \
	-I proto/log/v1 \
	--go_out=${TARGET}/v1/log --go_opt=paths=source_relative \
	--go-grpc_out=${TARGET}/v1/log --go-grpc_opt=paths=source_relative \
	log.proto

secret:
	mkdir -p ${TARGET}/v1/secret
	protoc \
	-I proto/secret/v1 \
	--go_out=${TARGET}/v1/secret --go_opt=paths=source_relative \
	--go-grpc_out=${TARGET}/v1/secret --go-grpc_opt=paths=source_relative \
	secret.proto

config:
	mkdir -p ${TARGET}/v1/config
	protoc \
	-I proto/config/v1 \
	--go_out=${TARGET}/v1/config --go_opt=paths=source_relative \
	--go-grpc_out=${TARGET}/v1/config --go-grpc_opt=paths=source_relative \
	config.proto

queue:
	mkdir -p ${TARGET}/v1/queue
	protoc \
	-I proto/queue/v1 \
	--go_out=${TARGET}/v1/queue --go_opt=paths=source_relative \
	--go-grpc_out=${TARGET}/v1/queue --go-grpc_opt=paths=source_relative \
	queue.proto

fmt:
	cd proto/config/v1 && protofmt -w config.proto 
	cd proto/queue/v1 && protofmt -w queue.proto
	cd proto/secret/v1 && protofmt -w secret.proto
	cd proto/queue/v1 && protofmt -w queue.proto