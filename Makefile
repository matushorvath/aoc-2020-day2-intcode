# See https://github.com/matushorvath/xzintbit for tools

XZINTBIT_DIR?=~/xzintbit

ICVM?=$(XZINTBIT_DIR)/vms/c/ic
ICAS?=$(XZINTBIT_DIR)/bin/as.input
ICLD?=$(XZINTBIT_DIR)/bin/ld.input
LIBXIB?=$(XZINTBIT_DIR)/bin/libxib.a

.PHONY: all build clean run

all: build run

build: b.input

run: build
	$(ICVM) b.input < input

clean:
	rm -f b.input b.o

b.input: b.o
	echo .$$ | cat $^ $(LIBXIB) - | $(ICVM) $(ICLD) > $@ || ( cat $@ ; false )

b.o: b.s
	cat $^ | $(ICVM) $(ICAS) > $@ || ( cat $@ ; false )
