;convert_case.s
;
;William Ersing, Matthew Mance
;Computer Architecture
;Final Assignment (Mano Computer)
;11/22/2013
;
;This program performs case conversion for every character in an input file.
;It was used to test the functionality of my Mano computer circuit.
;If the user enters 'l' the conversion is to lowercase.
;If the user enters 'u' the conversion is to uppercase.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        ORG 010     ;begin program at location 10           
CIF:    SKI         ;start the loop to wait for an input character check input flag         
        BUN CIF     ;if flag = 0 (no input character), do a busy wait and go back to CIF            
        INP         ;when flag =1, put the input character into the AC and clear flag           
        STA CHA     ;store the input character into CHA         
IF:     CMA         ;complement the AC          
        INC         ;2’s complement of the AC         
        ADD L       ;check if character is an “l” (108 +(-108) = 0)         
        SZA         ;if AC= 0, then CHA is an “l”, go to TH1            
        BUN ELS     ;otherwise go to the ELSE clause
TH1:    BSA LOW     ;proceed to convert to lowercase
        BUN END     ;proceed to the end of the main routine
ELS:    LDA CHA     ;load input character into the AC
        CMA         ;complement the AC
        INC         ;2’s complement of AC
        ADD U       ;check if character is a “u” (117 +(-117) = 0)
        SZA         ;if it is, go to TH2
        BUN CIF     ;otherwise character is not valid, go back to input busy wait
TH2:    BSA UP      ;proceed to convert to uppercase
END:    LDA D       ;load “D” into the AC
OD:     SKO         ;loop if the FGO is not enabled
        BUN OD      ;loop back to OD
        OUT         ;output from D from AC and clear flag
        LDA O       ;load 'O' into the AC
OO:     SKO         ;loop if the FGO is not enabled
        BUN OO      ;loop back to OO
        OUT         ;output O from AC and clear flag
        LDA N       ;load “N” into the AC
ON:     SKO         ;loop if the FGO is not enabled
        BUN ON      ;loop back to ON
        OUT         ;output N from AC and clear flag
        LDA E       ;load “E” into the AC
OE:     SKO         ;loop if the FGO is not enabled
        BUN OE      ;loop back to OE
        OUT         ;output from E from AC and clear flag
        HLT         ;end the program
LOW:    HEX 0       ;lowercase conversion subroutine, save return address here
        LDA TXT I   ;indirectly load the hex value of the first character
        ADD SPC     ;add 20 to change to lowercase
        STA TXT I   ;store the new lowercase value in the original position
        OUT         ;output converted letter to output register
        BUN LOW I   ;return to the saved address via indirect addressing
UP:     HEX 0       ;uppercase conversion subroutine, save return address here
        ISZ TXT     ;go to first letter that is already uppercase
        LDA TXT I   ;load it
        OUT         ;output 'I'
NXT:    ISZ TXT     ;Increment TXT pointer
        LDA TXT I   ;first, check for ' '. Indirectly load the hex value of the first character again
        CMA         ;complement the AC
        INC         ;2's complement
        ADD SPC     ;add 20 to check if the character is a 'space'
        SNA         ;skip if the AC is negative, if not negative, this character is a 'space.'
        BUN NXT     ;don't process and move on to next character
        LDA TXT I   ;then check for ',' Indirectly load the hex value of the first character
        CMA         ;complement the AC
        INC         ;2's complement
        ADD CMM     ;add HEX value for comma
        SNA         ;If negative, it's not a ',' keep checking. Otherwise, move on to next character
        BUN NXT     ;don't process and move on to next character
        LDA TXT I   ;then check for '.' Indirectly load the hex value of the first character
        CMA         ;complement the AC
        INC         ;2's complement
        ADD PER     ;add HEX value for period
        SNA         ;If negative, it's not a '.' If not, it is the end of the string. BUN to back to main routine
        BUN UP I    ;return to the saved address via indirect addressing
        LDA TXT I   ;load character
        OUT         ;output character before conversion
        LDA SPC     ;otherwise, convert it. load 20
        CMA         ;complement the AC
        INC         ;2's comp of AC
        STA NEG     ;store -20 in NEG
        LDA TXT I   ;reload the character to process it again
        ADD NEG     ;add -20 to convert to uppercase
        STA TXT I   ;store the new uppercase value in the original position
        OUT         ;output converted letter to output register
        BUN NXT     ;process next character
CHA:    HEX 0       ;Placeholder for input Character
L:      DEC 108     ;ASCII value for 'l'
U:      DEC 117     ;ASCII value for 'u'
P:      DEC 46      ;ASCII value for '.', the termination string
D:      HEX 44      ;HEX value for D, to be sent to OUTR
O:      HEX 4F      ;HEX value for O, to be sent to OUTR
N:      HEX 4E      ;HEX value for N, to be sent to OUTR
E:      HEX 45      ;HEX value for E, to be sent to OUTR
SPC:    HEX 20      ;HEX value for 'space' character
PER:    HEX 2E      ;HEX value for '.' character
CMM:    HEX 2C      ;HEX value for ',' character
NEG:    HEX 0       ;HEX place holder for negative 20, used to convert to uppercase
        ORG 100     ;jump to location 100 fot text file
TXT:    HEX 100     ;beginning of text file quote, place holder of first character address
        HEX 49      ;Uppercase 'I'
        HEX 66
        HEX 20
        HEX 70
        HEX 65
        HEX 6F
        HEX 70
        HEX 6C
        HEX 65
        HEX 20
        HEX 64
        HEX 6F
        HEX 20
        HEX 6E
        HEX 6F
        HEX 74
        HEX 20
        HEX 62
        HEX 65
        HEX 6C
        HEX 69
        HEX 65
        HEX 76
        HEX 65
        HEX 20
        HEX 74
        HEX 68
        HEX 61
        HEX 74
        HEX 20
        HEX 6D
        HEX 61
        HEX 74
        HEX 68
        HEX 65
        HEX 6D
        HEX 61
        HEX 74
        HEX 69
        HEX 63
        HEX 73
        HEX 20
        HEX 69
        HEX 73
        HEX 20
        HEX 73
        HEX 69
        HEX 6D
        HEX 70
        HEX 6C
        HEX 65
        HEX 2C
        HEX 20
        HEX 69
        HEX 74
        HEX 20
        HEX 69
        HEX 73
        HEX 20
        HEX 6F
        HEX 6E
        HEX 6C
        HEX 79
        HEX 20
        HEX 62
        HEX 65
        HEX 63
        HEX 61
        HEX 75
        HEX 73
        HEX 65
        HEX 20
        HEX 74
        HEX 68
        HEX 65
        HEX 79
        HEX 20
        HEX 64
        HEX 6F
        HEX 20
        HEX 6E
        HEX 6F
        HEX 74
        HEX 20
        HEX 72
        HEX 65
        HEX 61
        HEX 6C
        HEX 69
        HEX 7A
        HEX 65
        HEX 20
        HEX 68
        HEX 6F
        HEX 77
        HEX 20
        HEX 63
        HEX 6F
        HEX 6D
        HEX 70
        HEX 6C
        HEX 69
        HEX 63
        HEX 61
        HEX 74
        HEX 65
        HEX 64
        HEX 20
        HEX 6C
        HEX 69
        HEX 66
        HEX 65
        HEX 20
        HEX 69
        HEX 73
        HEX 2E      ;'.'
        END                 
