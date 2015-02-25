;add.s
;
;A simple arithmetic tool in assembly
;The following expression is evaluated:
;value = a + b - c + (- d)
;
;variables are initialized as such:
;a = 10
;b = 13
;c = -45
;d = -63
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		ORG	100
		LDA	SB1		;load input for 'c'
		CMA			;compliment 'c'
		INC			;increment 'c'
		ADD MN1		;add value of 'a' to 'c'
		STA	DF1		;store accumulator value in DF1
		CLA			;clear accumlator
		LDA	SB2		;load input for 'd'
		CMA			;compliment 'd'
		INC			;increment 'd'
		ADD	MN2		;add value of 'b' to 'd'
		STA	DF2		;store accumulator value in DF2
		CLA			;clear accumulator
		LDA	DF1		;load value of DF1
		ADD	DF2		;add value of DF1 to DF2
		STA	DF3		;store accumulator value to DF3
		HLT			;halt program
MN1:	DEC	10		;holds value of 'a'	;initialized to 10
MN2:	DEC	13		;holds value of 'b'	;initialized to 13
SB1:	DEC	-45		;holds value of 'c'	;initialized to -45
SB2:	DEC	-63		;holds value of 'd'	;initialized to -63
DF1:	HEX	0		;holds sum of 'a' and 'c'	;initialized to 0
DF2:	HEX	0		;holds sum of 'b' and 'd'	;initialized to 0
DF3:	HEX	0		;holds sum of DF1 and DF2	;initialized to 0
		END
