#!/usr/bin/make -f

-include Makefile.conf

setup:Makefile.conf

PROJECT:=protobuf.gpr
GPRBUILDFLAGS:=

all:compile test

Makefile.conf:  # IGNORE
	echo "export PREFIX?=$(shell dirname $(shell dirname $(shell which gnat)))" >${@}
	echo "export PATH:=${PATH}" >>${@}


compile:
	gprbuild  -P ${PROJECT} ${GPRBUILDFLAGS}


install:
	gprinstall  -P ${PROJECT} ${GPRBUILDFLAGS} --prefix=${DESTDIR}${PREFIX}

clean:
	git clean -xdf

test:
	bin/protobuf-main
