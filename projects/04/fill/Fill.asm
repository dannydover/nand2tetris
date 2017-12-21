// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

//    look for keyboard value higher than 0
//    blacken entire screen
//      set every register between screen and top to -1
//        16384 and 24577

// keyboard is 24576

//    look for keyboard value equal to 0
//    make entire screen white


// for (i=0; i < n; i++) P
//		draw 16 black pixels at the beginning of row i
// }

//  addr = SCREEN
//  n = RAM[0]
//  i = 0
//
//  LOOP:
//  	if i > n goto END
//  	  RAM[addr] = -1 	// 111111111111111
//  	// advance to next row
//  	addr = addr + 32	// 32 words ina row (32 * 16 = 512)
//  	i = i + 1
//  	goto LOOP
//  END:
//  	goto END

//@81     // max screen ram address - min screen ram address = 8191
//D = A
//@n
//M = D			// n = 8191

//@i
//M = 0			// i = 0

//@SCREEN
//D = A
//@address
//M = D			// address = 16384 (base address of the Hack screen)


(KEYLOOP)
  @8192     // max screen ram address - min screen ram address = 8191
  D = A
  @n
  M = D			// n = 8191

  @i
  M = 0			// i = 0

  @SCREEN
  D = A
  @address
  M = D			// address = 16384 (base address of the Hack screen)


  @24576    // If any key is touched, go into blackloop
  D = M
  @BLACKLOOP
  D;JGT

  @24576    // If no key is touched, go into whiteloop
  D = M
  @WHITELOOP
  D;JEQ


  @KEYLOOP
  0;JMP		// loop the KEYLOOP

(BLACKLOOP)
   @i
   D = M
   @n
   D = D - M
   @KEYLOOP
   D;JEQ		// if i > n goto KEYLOOP

   @address
   A = M		// writing to memory using a pointer
   M = -1		// RAM[address] = -1 (16 pixels)

   @i
   M = M + 1	// i = i + 1
   @1
   D = A
   @address
   M = D + M	// address = address + 1
   @BLACKLOOP
   0;JMP		// goto BLACKLOOP



(WHITELOOP)
   @i
   D = M
   @n
   D = D - M
   @KEYLOOP
   D;JEQ		// if i > n goto KEYLOOP

   @address
   A = M		// writing to memory using a pointer
   M = 0		// RAM[address] = 0 (16 pixels)

   @i
   M = M + 1	// i = i + 1
   @1
   D = A
   @address
   M = D + M	// address = address + 1
   @WHITELOOP
   0;JMP		// goto WHITELOOP




//(END)
//   @END		// program's end
//   0;JMP		// infinite loop
