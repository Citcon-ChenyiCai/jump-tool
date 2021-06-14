GOPATH:=$(shell go env GOPATH)
IDENTITY_FILE=~/.ssh/id_rsa
USERNAME=chenyi.cai

.PHONY: help
help:
	sh scripts/jump.sh -h

.PHONY: add-jump
add-jump:
	sh scripts/jump.sh --add-jump jump-sh 10.18.4.26 ${USERNAME} ${IDENTITY_FILE}

.PHONY: add-server
add-server:
	sh scripts/jump.sh --add-server ansible_02 10.2.5.8 ${USERNAME} ${IDENTITY_FILE} jump-ore

.PHONY: get-jump
get-jump:
	sh scripts/jump.sh --get-jump

.PHONY: get-server
get-server:
	sh scripts/jump.sh --get-server jump-ore

.PHONY: delete-jump
delete-jump:
	sh scripts/jump.sh --delete-jump jump-sh

.PHONY: delete-server
delete-server:
	sh scripts/jump.sh --delete-server ansible_02

.PHONY: deploy
deploy:
	sudo rm -rf /usr/local/bin/jump
	sudo cp scripts/jump.sh /usr/local/bin/jump
	sudo chmod +x /usr/local/bin/jump