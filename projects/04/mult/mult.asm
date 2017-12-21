// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

//R0
//(R0 + R0) R1 times


//    @R1
//    D=M
    @i     // i refers to RAM[16]
    M=0    // i=0
    @total // total refers to RAM[17]
    M=0    // total=0
(LOOP)
    @i
    D=M    // D=i
    @R1
    D=M-D  // D=R1-i
    @END
    D;JEQ  // If (i-R1) == 0 goto END

    @R0
    D=M    // D=R0
    @total
    M=M+D  // total=total+R0
    @i
    M=M+1  // i=i+1
    @LOOP
    0;JMP  // Goto LOOP
(END)
    @total //prepare to store total in R2
    D=M    // D=total
    @R2
    M=D

    @END
    0;JMP  // Infinite loop
