

build:
	zola build

deploy:
	rsync --archive --delete public/ petal:~/web/laststation-net/

.PHONY: all build deploy
