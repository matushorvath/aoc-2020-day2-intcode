# imports from libxib.a, which is the standard library
# that comes with the xzintbit assembler

.IMPORT read_identifier
.IMPORT read_number
.IMPORT get_input
.IMPORT print_num
.EXPORT report_libxib_error

# set up stack, call main function
    arb stack

    call main
    hlt

main:
.FRAME pos1, pos2, char, pwd, valid, tmp
    arb -6

    add 0, 0, [rb + valid]

loop:
    # parse one line

    call read_number
    add [rb - 2], 0, [rb + pos1]
    add [rb + pos1], -1, [rb + pos1]

    call get_input    # read '-'

    call read_number
    add [rb - 2], 0, [rb + pos2]
    add [rb + pos2], -1, [rb + pos2]

    call get_input    # read ' '
    call get_input
    add [rb - 2], 0, [rb + char]

    call get_input    # read ':'
    call get_input    # read ' '

    call read_identifier
    add [rb - 2], 0, [rb + pwd]

    call get_input   # read '\n'

    # count valid characters
    # self-modifying code, [ip + N] refers to N-th parameter in next instruction

    add 0, 0, [rb + tmp]

    add [rb + pwd], [rb + pos1], [ip + 1]
    eq  [0], [rb + char], [ip + 2]
    add [rb + tmp], 0, [rb + tmp]

    add [rb + pwd], [rb + pos2], [ip + 1]
    eq  [0], [rb + char], [ip + 2]
    add [rb + tmp], 0, [rb + tmp]

    # if we found exactly one valid character, increment the valid counter

    eq  [rb + tmp], 1, [ip + 1]
    jz  0, skip_increment
    add [rb + valid], 1, [rb + valid]
skip_increment:

    # print the counter

    add [rb + valid], 0, [rb - 1]
    arb -1
    call print_num
    out 10    # print '\n'

    jz 0, loop

    arb 6
    ret 0
.ENDFRAME

# dummy function needed by libxib
report_libxib_error:
    hlt

# stack space, 50 memory locations, growing down
    ds  50, 0
stack:

.EOF
