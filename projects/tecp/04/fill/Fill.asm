// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Put your code here.
//@24576
//@16384
(PREFILL)
@16384
D=A
@scr
M=D
(FILL)
@24576
D=A-D
@PREFILL
D;JEQ
@24576
D=M
@PRECLEAR
D;JEQ
@scr
AD=M
M=-1
@scr
M=M+1
@FILL
0;JMP
(PRECLEAR)
@16384
D=A
@scr
M=D
(CLEAR)
@24576
D=A-D
@PRECLEAR
D;JEQ
@24576
D=M
@PREFILL
D;JNE
@scr
AD=M
M=0
@scr
M=M+1
@CLEAR
0;JMP

