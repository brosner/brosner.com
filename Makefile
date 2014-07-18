export GOPATH:=$(shell pwd)

default: all

deps:
	go get -d -v brosner/...

build: deps
	go install brosner/cmd/...

clean:
	rm -rf bin pkg src/github.com

all: build
