#!/bin/bash

set -exou pipefail

go get -d github.com/nsf/gocode
go get -d golang.org/x/tools/cmd/goimports
go get -d github.com/rogpeppe/godef
go get -d golang.org/x/tools/cmd/oracle
go get -d golang.org/x/tools/cmd/gorename
go get -d github.com/golang/lint/golint
go get -d github.com/kisielk/errcheck
go get -d github.com/jstemmer/gotags
