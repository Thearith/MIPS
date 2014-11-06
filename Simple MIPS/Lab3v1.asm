start : lui $t1, 0x0000
ori $t1, 0x0001 # constant 1 lower half word
lui $t0, 0x1002 # DIP address upper half word before offset
ori $t0, 0x8001 # DIP address lower half word before offset
lw $t4, 0x7fff($t0) # read from DIP address 0x10030000 = 0x10028001 + 0x7fff
lui $t0, 0x1002 # LED address upper half word before offset
ori $t0, 0x0001 # LED address lower half word before offset
ori $zero, 0xffff # writing to zero. should have no effect
loop: lui $t2, 0x0000 # delay counter (n) upper half word if using slow clock
ori $t2, 0x0004 # delay counter (n) lower half word if using slow clock
lui $t2, 0x00ff # delay counter (n) upper half word if using fast clock 
ori $t2, 0xffff # delay counter (n) lower half word if using fast clock
delay: sub $t2, $t2, $t1 # begining of delay loop
slt $t3, $t2, $t1
beq $t3, $zero, delay # end of delay loop
sw $t4, 0xffffffff($t0) # write to LED address 0x10020000 = 0x10020001 + 0xffffffff.
nor $t4, $t4, $zero # flip the bits
j loop # infinite loop; # repeats every n*3 (delay instructions) + 5 (non-delay instructions).