FROM xena/go

ADD . /eircdsite

ENV WIKI_VERSION 20151110

RUN apk add --no-cache make git &&\
    git clone https://github.com/jroimartin/sw /sw &&\
    cd /sw && make install &&\
    go get github.com/russross/blackfriday-tool &&\
    cd /eircdsite/site &&\
    git clone https://github.com/Elemental-IRCd/elemental-ircd.wiki.git wiki &&\
    cd wiki && rm -rf .git && mv Home.md index.md && touch technical/index.md && rm _Footer.md ;\
    cd /eircdsite && make build; \
    go get github.com/Xe/tools/quickserv/... &&\
    apk del make git

CMD quickserv -port 9090 -dir /eircdsite/site.static
