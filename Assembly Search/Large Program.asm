;
;  Large Program.asm
;  Large Program
;
;  Created by Blake Williams on 4/25/19.
;  Copyright © 2019 Blake Williams. All rights reserved.
;

; This program utilizes a custom hash map for indirect-addressing of strings.
; This is not the most space-efficient or file-size efficient approach, however,
; it allows the computer to perform much of the processing while the user is 
; typing. This way, when the ENTER key is pressed, an address is calculated simply
; by multiplying the hash value by 2. This memory address holds the address of
; the desired string. By using this method, the time elapsed between ENTER key-press
; and console output is minimized.
;
; It is important to note that the hash value includes a tripling of the first 
; character due to some "simple" sums being identical. Also a doubling of the entire
; hash allows space for a verification value to preceed each entry without overlap.
;


.ORIG x3000

; load all code addresses into hash memory locations here

      LD R2 TESTC       ; R2 holding test code
      AND R3 R3 #0      ; R3 holding 0 for string termination
      LEA R1 ADDC       ; R1 holds address of opcode string
      LD R0 ADDH        ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 ANDC       ; R1 holds address of opcode string
      LD R0 ANDH        ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 BRC        ; R1 holds address of opcode string
      LD R0 BRH         ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 JMPC       ; R1 holds address of opcode string
      LD R0 JMPH        ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 JSRC       ; R1 holds address of opcode string
      LD R0 JSRH        ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 JSRRC      ; R1 holds address of opcode string
      LD R0 JSRRH       ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 LDC        ; R1 holds address of opcode string
      LD R0 LDH         ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 LDIC       ; R1 holds address of opcode string
      LD R0 LDIH        ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 LDRC       ; R1 holds address of opcode string
      LD R0 LDRH        ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 LEAC       ; R1 holds address of opcode string
      LD R0 LEAH        ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 NOTC       ; R1 holds address of opcode string
      LD R0 NOTH        ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 RETC       ; R1 holds address of opcode string
      LD R0 RETH        ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 RTIC       ; R1 holds address of opcode string
      LD R0 RTIH        ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 STC        ; R1 holds address of opcode string
      LD R0 STH         ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 STIC       ; R1 holds address of opcode string
      LD R0 STIH        ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 STRC       ; R1 holds address of opcode string
      LD R0 STRH        ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

      LEA R1 TRAPC      ; R1 holds address of opcode string
      LD R0 TRAPH       ; R0 holds hash val
      STR R2 R0 #-1     ; store test code into test location
      STR R1 R0 #0      ; store opcode into hash location
      STR R3 R0 #1

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ logic section

; R1 is garbage for comparisons or temp vals
; R2 is running hash value

      LD R4 UPPER       ; const R4 is Uppercase divider
      LD R5 ENTER       ; const R5 is ENTER ASCII
      LD R6 QUIT        ; const R6 is QUIT hash value

RESTART   LEA R0 WSTR   ; load welcome string location
      PUTS              ; print welcome string
      LD R2 OK          ; clear R2 for hash value

UIN   GETC              ; gets char into R0
      OUT               ; echos char
      ADD R1 R0 R5      ; compares R0 with ENTER ASCII
      BRnp ROLL         ; if not ENTER
      ADD R1 R2 R6      ; compares R2 with QUIT hash
      BRnp CHECK        ; if not QUIT
      HALT

ROLL  ADD R1 R0 R4      ; compare R0 to uppercase
      BRnz #2           ; if uppercase already
      LD R1 DIF 
      ADD R0 R0 R1      ; make R0 uppercase
      LD R1 NOK         ; load negative of mem base to R1
      ADD R1 R2 R1      ; compare current hash check for chars
      BRz ROLL1         ; if hash is empty
      ADD R2 R2 R0      ; add char to hash register
      JSR UIN

ROLL1 AND R1 R1 #0      ; clear R1
      ADD R1 R0 #0      ; put R0 into R1
      ADD R0 R0 R1
      ADD R0 R0 R1      ; triples current char
      ADD R2 R0 R2      ; adds R0 to running hash
      JSR UIN

CHECK LD R1 TEST        ; loads test value to R1
      ADD R2 R2 R2      ; doubles R2 to resolve hash map
      LDR R3 R2 #-1     ; loads value in location of hash test val into R3
      ADD R1 R1 R3      ; compares R3 to TEST value
      BRnp ERROR        ; if not a valid hash
      AND R0 R0 #0      ; clear R0
      LDR R0 R2 #0      ; put memory address hash into R0
      PUTS              ; print the code at memory hash
      LD R0 NEWL
      OUT
      JSR RESTART       ; starts the program over, since hash was not QUIT

ERROR LEA R0 ERR        ; load memory location of error message into R0
      PUTS              ; prints error message
      LD R0 NEWL
      OUT
      JSR RESTART       ; loops back to restart block

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ENTER  .FILL #-10       ; negative of ASCII for "ENTER"
QUIT   .FILL #-4581     ; negative of "QUIT" hash
UPPER  .FILL #-91       ; negative of upper end ASCII of uppercase letters
DIF    .FILL #-32       ; difference between upper and lower case
TEST   .FILL x5555      ; val to be used to determine validity
OK     .FILL x1000      ; memory base for code hash list
NOK    .FILL #-4096     ; negative of OK for testing first character
TESTC  .FILL xAAAB      ; to be inserted before every ascii string hash

NEWL   .FILL x0A
ADDC   .STRINGZ 0001
ANDC   .STRINGZ 0101
BRC    .STRINGZ 0000
JMPC   .STRINGZ 1100
JSRC   .STRINGZ 0100
JSRRC  .STRINGZ 0100
LDC    .STRINGZ 0010
LDIC   .STRINGZ 1010
LDRC   .STRINGZ 0110
LEAC   .STRINGZ 1110
NOTC   .STRINGZ 1001
RETC   .STRINGZ 1100
RTIC   .STRINGZ 1000
STC    .STRINGZ 0011
STIC   .STRINGZ 1011
STRC   .STRINGZ 0111
TRAPC  .STRINGZ 1111

ADDH   .FILL x2296
ANDH   .FILL x22AA
BRH    .FILL x2230
JMPH   .FILL x22F6
JSRH   .FILL x2306
JSRRH  .FILL x23AA
LDH    .FILL x2250
LDIH   .FILL x22E2
LDRH   .FILL x22F4
LEAH   .FILL x22D4
NOTH   .FILL x231A
RETH   .FILL x231E
RTIH   .FILL x2326
STH    .FILL x229A
STIH   .FILL x232C
STRH   .FILL x233E
TRAPH  .FILL x23BE

ERR .STRINGZ Error:_Not_an_instruction 

WSTR .STRINGZ Enter_a_valid_LC-3_instruction: 

.END

