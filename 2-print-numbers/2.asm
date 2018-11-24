; To run in C64: Type SYS 49152

; aliases / variables / labels

print		= $ffd2

!macro a_mod_n .n {
		sec
-		sbc #.n		; subtract a with n until a is lower than 0
		bcs -		; branch / jump to "-" if carry is set
		adc #.n		; add back last n to a, now a is the remainder of a mod n 
}

; divide a by n, return value in y
!macro a_div_by .n {
		ldy #0
		sec
-		iny
		sbc #.n
		bcs -		; jump if carry is set
		dey
}

; a	accumulator 8 bits
; x	index 8 bits
; y	index 8 bits
; pc	program counter 16 bits
; st	status register 8 bits
;	- C carry
;	- N negative
;	- V overflow
;	- I interrupt
;	- Z zero flag

;	absolut address
;	direct value
;	indirect address
;
;   addition
;   adc		- add with carry
;   		example:	
;						lda #$00	; load a = 0
;						clc			; clear carry flag
;						adc #$32	; add 50 + c to a
;			a = 50
;						lda #254	; load a = 254
;						clc			; c = 0
;						adc #3		; add 3 to a (254 + 3 + c = 1), overflows, sets carry! c = 1
;						sta tmp
;						lda #0		; a = 0
;						adc #0		; a + 0 + c = 1
;						sta tmp2	; a = 1


;	subtraction
;	sbc		- subtract with carry
; 			example:
;						lda #12		; load a = 12
;						sec			; set carry flag
;						sbc #7		; subtact 7 from a
;			a = 5

; RUN command

		*=$0801					; Start adress for BASIC program

		!byte $0c,$08,$0a,$00,$9e		; $0c $08 is end address of line in bytes, $0a $00 is line 10, then sys command: $9e
		!byte $20,$32,$30,$36,$34		; space $20, then string "2064" which is $0810 in hex

		; program start address
		*=$0810

		; 16 bits addition and subtraction by handling overflows with carry
			; clc

			; lda num_16bit	; c019
			; adc #$c7		; $41 + $c7 = $08 ; overflows, carry is set to 1, c = 1
			; sta num_16bit		

			; lda num_16bit+1	; c01a
			; adc #$02		; 02 + 02 + c = 05 ; carry resets after this, c = 0
			; sta num_16bit+1

			; ;sec				; set carry, c = 1
			; lda num_16bit	; a = 8, num_16bit = $0508
			; sbc #$0a		; a - 10 => 8 - 10 = 254, oops, we need to borrow, this op resets carry to 0
			; sta num_16bit
			; lda num_16bit+1	; a = 5
			; sbc #$00
			; sta num_16bit+1	; a = 4, num_16bit = $04fe

			; $0241 + $02c7 = $0508

		lda #255
		jsr print_a

		rts

print_a
		; a = 178, we want to print the "1" character of 178 first
		pha
		+a_div_by 100	; divide a by 100, but returns value in y, so...
		tya				; transfer y to a
		cmp #0			; if a == 0;
		beq +			; go to +				
		clc		
		adc #48
		jsr print
+
		pla
		pha
		+a_mod_n 100	; return what is not devidablae by 10		
		+a_div_by 10	; divide a by 10, but returns value in y, so...
		tya				; transfer y to a
		cmp #0			; if a == 0;
		beq +			; go to +
		clc		
		adc #48
		jsr print
+
		pla
		+a_mod_n 10
		clc
		adc #48
		jsr print
		rts

num_16bit
		!word $0241
tmp
		!byte $00
; 		ldx #$00
; textloop	lda str,x
; 		jsr print
; 		inx	
; 		cmp #$0d
; 		bne textloop
; 		rts

; str		!text "HELLO WORLD!"
; 		!byte $0d	; Return
; $c01d		-
