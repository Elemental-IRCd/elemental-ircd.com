build:
	sw site

server: build
	quickserv -dir site.static -port 9001

all: build
