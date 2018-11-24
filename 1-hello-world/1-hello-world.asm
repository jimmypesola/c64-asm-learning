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

;	absolut address
;	direct value
;	indirect address


		; program start address
		*=$c000

		ldx #$00
textloop	lda str,x
		jsr print
		inx	
		cmp #$0d
		bne textloop
		rts

str		!text "HELLO WORLD!"
		!byte $0d	; Return
; $c01d		-
