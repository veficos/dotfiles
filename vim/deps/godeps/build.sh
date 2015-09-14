#!/bin/bash

tar xf godeps.tar.gz

cd godeps

export GOBIN=`pwd`/bin
export GOPATH=`pwd`

go get  -v github.com/nsf/gocode
go get  -v golang.org/x/tools/cmd/goimports
go get  -v github.com/rogpeppe/godef
go get  -v golang.org/x/tools/cmd/oracle
go get  -v golang.org/x/tools/cmd/gorename
go get  -v github.com/golang/lint/golint
go get  -v github.com/kisielk/errcheck
go get  -v github.com/jstemmer/gotags
