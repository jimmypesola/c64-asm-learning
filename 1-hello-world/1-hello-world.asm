; aliases / variables / labels

print		= $ffd2

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

;	lda operator
;	--------------------------------------
;	absolute address:	lda $1253
;	direct value:		lda #$45
;	indirect address:	lda ($fc),y


		; program start address
		*=$c000

		ldx #$00
textloop	lda str,x
		jsr print
		inx	
		cmp #$0d
		bne textloop
		jmp next_print

str		!text "HELLO WORLD!"
		!byte $0d	; Return
; $c01d		-

next_print	ldx #$00
textarrayloop	lda str_lo,x
		sta $fc
		lda str_hi,x
		sta $fd

		ldy #$00
textloop2	lda ($fc),y
		jsr print
		iny	
		cmp #$0d
		bne textloop2

		inx
		cpx #$02
		bne textarrayloop
		rts

str_lo		!byte <string1,<string2
str_hi		!byte >string1,>string2

; $c01d		-
string1		!text "HELLO "
		!byte $0d	; Return
string2		!text "WORLD"
		!byte $0d	; Return
