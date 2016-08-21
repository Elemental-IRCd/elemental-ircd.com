build:
	sw site
	touch site.static/health

server: build
	quickserv -dir site.static -port 9001

all: build
