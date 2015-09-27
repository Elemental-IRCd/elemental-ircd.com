FROM golang:1.5.1

RUN git clone https://github.com/jroimartin/sw /sw &&\
	cd /sw && make install

ADD . /eircdsite

RUN cd /eircdsite && sw site

EXPOSE 5000

RUN go get github.com/Xe/tools/quickserv/...

ENV VIRTUAL_HOST elemental-ircd.com

CMD quickserv -port 5000 -dir /eircdsite/site.static
