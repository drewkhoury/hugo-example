DOCKER_IMAGE_HUGO				?= "klakegg/hugo:0.78.2"
DOCKER_IMAGE_SHELL			?= "klakegg/hugo:0.78.2-alpine"

.PHONY : help
help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY : shell
shell:          ## Launch hugo shell.
	docker run --rm -it -v $$(pwd):/src ${DOCKER_IMAGE_SHELL} shell

.PHONY : server
server:         ## Launch hugo server.
	docker run --rm -it -v $$(pwd):/src -p 1313:1313 ${DOCKER_IMAGE_HUGO} server

.PHONY : build
build:          ## Build hugo.
	docker run --rm -v $$(pwd):/src ${DOCKER_IMAGE_HUGO} --minify

.PHONY : deploy
deploy: build   ## Deploy hugo.
	docker run --rm -v $$(pwd):/src -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY ${DOCKER_IMAGE_HUGO} deploy
