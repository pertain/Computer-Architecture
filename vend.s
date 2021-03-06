;vend.s
;
;A vending machine in assembly
;User inputs quarters or dimes to purchase a bottle of soda for $1.00
;Appropriate change is to be dispensed after the bottle of soda
;Assume good behavior (no error checking) of only depositing quarters or dimes
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        ORG 010	
CIF:    SKI         ;begin main routine  ;to insert coin, set FGI = 1  ;check input flag (CIF)
        BUN CIF     ;if input flag is 0 (FGI = 0), busy wait 
        INP         ;when FGI = 1, load INPR into AC  ;to insert a quarter, set INPR = Q  ;reset flag (FGI = 0)
        STA MON     ;store coin in MON
IF:     CMA         ;complement coin value
        INC         ;increment the compliment (coin value is now a subtrahend)
        ADD Q       ;determine if coin is a quarter
        SZA         ;if AC = 0 then MON (the coin deposited) is a Quarter  ;skip to THEN clause
        BUN ELS     ;if AC ≠ 0  ;go to ELSE clause
THN:    LDA QTR     ;load value of quarter (25) into AC
        STA COI     ;set coin (COI) to quarter (25)
        BUN EIF     ;coin is set  ;go to end of IF THEN statement
ELS:    LDA DIM     ;load value of dime (10) into AC
        STA COI     ;set coin (COI) to dime (10)
EIF:    LDA SUM     ;sum is cumulative value of coins
        ADD COI     ;add current coin (COI) to SUM
        STA SUM     ;store the updated SUM
IFS:    CMA         ;complement sum value
        INC         ;increment the complement (sum value is now a subtrahend)
        ADD MAX     ;determine if SUM has reached MAX
        SNA         ;if AC < 0, then SUM exceeds MAX  ;skip to CHANGE subroutine
        BUN CK2     ;SUM does not exceed MAX  ;go to CK2 statement to determine if SUM = MAX
PT2:    BSA CHG     ;call CHANGE subroutine to calculate appropriate change
COF:    SKO         ;begin main change output loop  ;to return coin, set FGO = 1  ;check output flag (COF)
        BUN COF     ;if output flag is 0 (FGO = 0), busy wait
        LDA CNO     ;when FGO = 1, load coin to be returned (CNO) into AC
        OUT         ;return coin (D) to OUTR  ;reset flag (FGO = 0)
CO2:    SKO         ;begin soda output loop  ;to dispense soda, set FGO = 1  ;check output flag (COF)
        BUN CO2     ;if output flag is 0 (FGO = 0), busy wait
DON:    LDA SDA     ;when FGO = 1, load soda (SDA) into AC
        OUT         ;dispense soda (S) to OUTR  ;reset flag (FGO = 0)
        HLT         ;end of instructions
CK2:    SZA         ;if AC = 0, then SUM = MAX  ;skip to DONE branch
        BUN CIF     ;MAX has not been reached  ;return to start of main routine for another coin
        BUN DON     ;go to DONE statement to dispense soda
CHG:    HEX 0       ;main routine branch point address (026) is stored here  ;initialized to 0
TOT:    LDA SUM     ;load value of SUM into AC
        CMA         ;complement max value
        INC         ;increment the complement (max value is now a subtrahend)
        ADD MAX     ;determine total value of change
        STA REM     ;store remaining change value in REM
CS1:    LDA REM     ;load remaining change into AC
        ADD NKL     ;determine if change to return = 5
        SNA         ;if AC < 0, then change due is more than 5  ;skip to CASE2 statement
        BUN C5      ;change due = 5  ;go to C5 statement
CS2:    LDA REM     ;load remaining change into AC
        ADD DIM     ;determine if change to return = 10
        SNA         ;if AC < 0, then change due is more than 10  ;skip to CASE3 statement
        BUN C10     ;change due = 10  ;go to C10 statement
CS3:    LDA REM     ;load remaining change into AC
        ADD NKL     ;add Nickel to AC
        ADD DIM     ;add Dime to AC  ;determine if change to return = 15
        SNA         ;if AC < 0, then change due is more than 15  ;skip to CASE4 statement
        BUN C15     ;change due = 15  ;go to C15 statement
CS4:    BUN C20     ;change due = 20  ;go to C20 statement
C5:     LDA N       ;set Nickel as first coin to be returned
        STA CNO     ;place Nickel in CNO
        BUN CN1     ;change has been calculated  ;go to CN1 to return change
C10:    LDA D       ;set Dime as first coin to be returned
        STA CNO     ;place Dime in CNO
        BUN CN1     ;change has been calculated  ;go to CN1 to return change
C15:    LDA N       ;set Nickel as first coin to be returned
        STA CNO     ;place Nickel in CNO
        LDA D       ;set Dime as next coin to be returned
        STA NXT     ;store Dime in NEXT coin
        BUN CN1     ;change has been calculated  ;go to CN1 to return change
C20:    LDA D       ;set Dime as first coin to be returned
        STA CNO     ;place Dime in CNO
        LDA D       ;set Dime as next coin to be returned
        STA NXT     ;store Dime in NEXT coin
        BUN CN1     ;change has been calculated  ;go to CN1 to return change
CN1:    SKO         ;begin sub change output loop  ;to return coin, set FGO = 1  ;check output flag (COF) 
        BUN CN1     ;if output flag is 0 (FGO = 0), busy wait
        LDA CNO     ;when FGO = 1, load coin to be returned (CNO) into AC
        OUT         ;return coin (D or N) to OUTR  ;reset flag (FGO = 0)
        LDA NXT     ;loads next coin to be returned into AC
CN2:    STA CNO     ;stores next coin to be returned into CNO 
        BUN CHG	I   ;subroutine is finished, return to main routine
MON:    HEX 0       ;holds ASCII value for current coin (Q or D)  ;initialized to 0
Q:      DEC 81      ;holds ASCII value for Q (‘Quarter’) ;static value  ;initialized to 81
D:      DEC 68      ;holds ASCII value for D (‘Dime’) ;static value  ;initialized to 81
N:      DEC 78      ;holds ASCII value for N (‘Nickel’) ;static value  ;initialized to 81
QTR:    DEC 25      ;holds value of Quarter  ;static value  ;initialized to 25
DIM:    DEC 10      ;holds value of Dime  ;static value  ;initialized to 10
NKL:    DEC 5       ;holds value of Nickel  ;static value  ;initialized to 5
COI:    HEX 0       ;holds value of current coin  ;initialized to 0
SUM:    HEX 0       ;holds cumulative value of inserted coins  ;initialized to 0
MAX:    DEC 100     ;holds price of soda  ;static value  initialized to 100
CNO:    HEX 0       ;holds value of coin to be returned  ;initialized to 0
SDA:    DEC 83      ;holds ASCII value for S (‘soda’)  ;static value  ;initialized to 83
REM:    HEX 0       ;holds total value of remaining change to be returned  ;initialized to 0
NXT:    HEX 0       ;holds ASCII value for second coin to be returned  ;initialized to 0
        END
