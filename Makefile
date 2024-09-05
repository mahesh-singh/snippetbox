GO_VERSION :=1.23.0

.PHONY: install-go init-go

setup: install-go init-go

#TODO: does not work on local setup

install-go:
	wget “https://golang.org/dl/go$(GO_VERSION).linux-amd64.tar.gz”
	sudo “sudo tar -C /usr/local -xzf go$(GO_VERSION).linux-amd64.tar.gz”
	rm go$(GO_VERSION).linux-amd64.tar.gz

init-go:
	echo export PATH=$$PATH:/usr/local/go/bin' >> $${HOME}/.bashrc
	echo 'export PATH=$$PATH:$${HOME}/go/bin' >> $${HOME}/.bashrc

build:
	go build -o web ./cmd/web


