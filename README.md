# Advent of Code 2020, Day 2, Intcode Solution

## Sources

The file `b.s` contains Intcode assembly source code. It imports some functions from [Xzintbit](https://github.com/matushorvath/xzintbit) `libxib.a` standard library.

The file `b.input` is the Intcode program compiled from `b.s`. You can execute this on your own Intcode VM if you wish, passing `input` file as standard input to the Intcode program.

## Tools

You will need the assembler and linker from here: https://github.com/matushorvath/xzintbit

## How to Build

Sync and build the [Xzintbit](https://github.com/matushorvath/xzintbit) assembler toolkit.

Edit `Makefile` to set the correct path to your built tools. You can either use the Xzintbit Intcode VM, or add a path to your own.

Run `make build`.

```shell
$ make build
cat b.s | ~/xzintbit/vms/c/ic ~/xzintbit/bin/as.input > b.o || ( cat b.o ; false )
echo .$ | cat b.o ~/xzintbit/bin/libxib.a - | ~/xzintbit/vms/c/ic ~/xzintbit/bin/ld.input > b.input || ( cat b.input ; false )
$ cat b.input
109,240,21101,11,0,-1,109,-1,1106,0,12,99,109,
✁⋯⋯⋯⋯⋯
0,0,0,1106,0,1222,109,1,109,3,2106,0,-3
```

## How to Execute

Run `make run`. Since there is no way to determine end of input in plain Intcode, the algorithm prints current result after every step. When it runs out of inputs, the program will crash and the last value printed is the answer.

```shell
$ make run
 make run
~/xzintbit/vms/c/ic b.input < input || true
0
1
1
1
✁⋯⋯⋯⋯⋯
280
280
no more inputs
```
