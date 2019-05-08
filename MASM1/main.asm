; Luis Cortez
; Module 6: Programming Project 3
;
INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
     
; Excercise 1 prompt data
     promptOne BYTE "Please enter a sentence: ", 0

; Excercise 2 prompt data
     promptTwo BYTE "Please enter a character: ", 0
     promptThree BYTE "Number of times your character was in the string: ", 0

; Excercise 3 prompt data
     promptFour BYTE "Please enter the first sentence: ", 0
     promptFive BYTE "Please enter the second sentence: ", 0

     buffOne BYTE 256 DUP(?)       ; String storage buffers. 
     buffTwo BYTE 256 DUP(?)

     characterInput BYTE ?
     charCounter BYTE ?

     sentenceLengthOne DWORD 0
     sentenceLengthTwo DWORD 0

     tempString DWORD ?
     totalString DWORD 9000 DUP(?)

     ; Exercise 4 addon stuff
     mySource BYTE 0Ah, 1Bh, 2Ch, 3Dh, 4Eh, 5Fh, 10h, 43h

     myByte1 BYTE 8 DUP(0)
     myByte2 BYTE 8 DUP(0)


.code


main proc

     ;CALL ExerciseOne
     ;CALL ExcerciseTwo
     CALL ExcerciseThree






     invoke ExitProcess, 0
main endp

; Exercise one will ask the user to input a sentence.
; It will then count the number of characters used in the sentence
; and display it in both decimal and hexadecimal form.
ExerciseOne proc

     MOV EDX, OFFSET promptOne     ; Prompt user for input
     CALL WriteString

     MOV EDX, OFFSET buffOne
     MOV ECX, SIZEOF buffOne
     CALL ReadString               ; Read in user input
     MOV sentenceLengthOne, EAX	; Move length
     MOV EAX, sentenceLengthOne
	CALL WriteDec

     CALL newLine

     MOV EAX, sentenceLengthOne
     CALL WriteHex
     MOV AL, 'h'
     CALL WriteChar

     CALL newLine

     MOV EDX, OFFSET buffOne
     CALL WriteString

     CALL newLine

     RET
ExerciseOne endp


; Excercise two will ask a user to enter a sentence, followed
; by a character. It will then scan the sentence and tell the
; user the number of instances the character was used in the
; sentence.
ExcerciseTwo proc

     MOV EDX, OFFSET promptOne     ; Prompt user for input - sentence
     CALL WriteString

     MOV EDX, OFFSET buffTwo
     MOV ECX, SIZEOF buffTwo
     CALL ReadString               ; Read in user input 
     MOV sentenceLengthOne, EAX	; Move length of sentence
     MOV EAX, sentenceLengthOne
	
     MOV EDX, OFFSET promptTwo     ; Prompt user for input - character
     CALL WriteString
     CALL ReadChar
     MOV characterInput, AL

     MOV ESI, OFFSET buffTwo       ; Moving to offset of sentence
     MOV DL, 0                     ; Setting character count to 0
     MOV ECX, sentenceLengthOne    ; Number of characters to scan

miLoop :  
     CMP AL, [ESI]
     JNZ keepGoing                 ; Jump if not zero flag
     INC DL

keepGoing :
     INC ESI                       ; Move to next char
     LOOP miLoop

     MOV charCounter, DL           ; Places final char total in charCounter variable

     CALL newLine

     MOV EDX, OFFSET promptThree   ; Loads user prompt and prints it out
     CALL WriteString

     MOV EAX, 0000h
     MOV AL, charCounter           ; Loads chars and writes them out
     CALL WriteDec

     CALL newLine

     RET

ExcerciseTwo endp




; Excercise Three - will prompt the user for a sentence - it will then ask the user to input another
; string and then ask them at what location they would like the string to be inserted. It will
; then insert that string into the original sentence.
ExcerciseThree proc

     MOV EDX, OFFSET promptFour     ; Prompt user for input - sentence
     CALL WriteString

     MOV EDX, OFFSET buffOne
     MOV ECX, SIZEOF buffOne
     CALL ReadString               ; Read in user input 
     MOV sentenceLengthOne, EAX	; Move length of sentence

     CALL newLine

     MOV EDX, OFFSET buffOne
     CALL WriteString

     CALL newLine

     MOV EDX, OFFSET promptFive     ; Prompt user for input - sentence
     CALL WriteString
     
     MOV EDX, OFFSET buffTwo
     MOV ECX, SIZEOF buffTwo
     CALL ReadString				; Read in user input 
     MOV sentenceLengthTwo, EAX		; Move length of sentence

     MOV EDX, OFFSET buffTwo
     CALL WriteString

     call newLine
     cld
     MOV ESI, OFFSET buffOne
     MOV EDI, OFFSET totalString
     MOV ECX, sentenceLengthOne
     REP MOVSD

     MOV EDX, OFFSET totalString
     CALL WriteString


     CLD
     MOV ESI, OFFSET buffTwo
     MOV EDI, OFFSET totalString
     mov ECX, sentenceLengthOne
     REP MOVSD

     MOV EAX, totalString
     CALL WriteString

     CALL newLine
     
     MOV EAX, sentenceLengthOne
     ADD EAX, sentenceLengthTwo
     CALL WriteDec

     CALL newLine

     MOV EAX, sentenceLengthOne
     ADD EAX, sentenceLengthTwo
     CALL WriteHex
     MOV AL, 'h'
     CALL WriteChar

     CALL newLine

     RET





ExcerciseThree endp

;ExerciseFour proc
;
     ;; Data declared above - mySource BYTE 0Ah, 1Bh, 2Ch, 3Dh, 4Eh, 5Fh, 10h, 43h
;
     ;MOV AL, 2Ch                   ; Looking for the occurences of 2Ch
     ;MOV ESI, OFFSET mySource      ; Moves data to ESI register for scan
     ;MOV DL, 0                     ; Start my occurance counter
     ;MOV ECX, 8                    ; Number of items to scan - which would normally come from SIZEOF feature
     ;
;myLoop :
     ;CMP AL, [ESI]                 ; Compare [ESI] to 2Ch
     ;JNZ keepGoing                 ; Jump if not zero ( not equal ) to keepGoing
     ;INC DL
;
;keepGoing :
     ;INC ESI                       ; Update the location of ESI in the memory to + 1
;
     ;LOOP myLoop                   ; Now loops back 
;
;
;
;
;
;
;ExerciseFour endp
















; Simple method to clean up code.
newLine proc

     MOV AL, 0Ah    		     ; Quick newline method to stop repeating myself.
     CALL WriteChar
     MOV AL, 0Dh
     CALL WriteChar

     RET
newLine endp


end main

