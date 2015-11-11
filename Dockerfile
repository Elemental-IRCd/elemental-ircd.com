FROM golang:1.5.1

RUN git clone https://github.com/jroimartin/sw /sw &&\
    cd /sw && make install &&\
    go get github.com/russross/blackfriday-tool

ADD . /eircdsite

ENV WIKI_VERSION 20151110
RUN cd /eircdsite/site &&\
    git clone https://github.com/Elemental-IRCd/elemental-ircd.wiki.git wiki &&\
    cd wiki && rm -rf .git && mv Home.md index.md && touch technical/index.md && rm Footer.md

RUN cd /eircdsite && sw site

EXPOSE 5000

RUN go get github.com/Xe/tools/quickserv/...

ENV VIRTUAL_HOST elemental-ircd.com

CMD quickserv -port 5000 -dir /eircdsite/site.static
