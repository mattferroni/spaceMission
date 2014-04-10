opt subtitle "HI-TECH Software Omniscient Code Generator (Lite mode) build 6738"

opt pagewidth 120

	opt lm

	processor	16F887
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 4 "C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	psect config,class=CONFIG,delta=2 ;#
# 4 "C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	dw 0x23E2 ;#
	FNCALL	_main,_lcd_init
	FNCALL	_main,_lcd_clear
	FNCALL	_main,_lcd_puts
	FNCALL	_main,_initCountDown
	FNCALL	_main,_updateSpace
	FNCALL	_main,_endMission
	FNCALL	_main,_displayCountDown
	FNCALL	_main,_displayPoints
	FNCALL	_main,_displaySpace
	FNCALL	_main,_updateAsteroidsSpeed
	FNCALL	_lcd_init,_lcd_write
	FNCALL	_lcd_init,_lcd_clear
	FNCALL	_displaySpace,_lcd_clear
	FNCALL	_displaySpace,_lcd_puts
	FNCALL	_lcd_puts,_lcd_write
	FNCALL	_lcd_clear,_lcd_write
	FNCALL	_updateSpace,_generateAsteroid
	FNCALL	_updateSpace,_checkCollision
	FNROOT	_main
	FNCALL	intlevel1,_isr
	global	intlevel1
	FNROOT	intlevel1
	global	_line0
	global	_line1
psect	idataBANK0,class=CODE,space=0,delta=2
global __pidataBANK0
__pidataBANK0:
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	31

;initializer for _line0
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	line	32

;initializer for _line1
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	retlw	02Dh
	global	_map
psect	strings,class=STRING,delta=2
global __pstrings
__pstrings:
;	global	stringdir,stringtab,__stringbase
stringtab:
;	String table - string pointers are 1 byte each
	btfsc	(btemp+1),7
	ljmp	stringcode
	bcf	status,7
	btfsc	(btemp+1),0
	bsf	status,7
	movf	indf,w
	incf fsr
skipnz
incf btemp+1
	return
stringcode:stringdir:
movlw high(stringdir)
movwf pclath
movf fsr,w
incf fsr
	addwf pc
__stringbase:
	retlw	0
psect	strings
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	15
_map:
	retlw	03Fh
	retlw	06h
	retlw	05Bh
	retlw	04Fh
	retlw	066h
	retlw	06Dh
	retlw	07Dh
	retlw	07h
	retlw	07Fh
	retlw	06Fh
	global	_map
	global	_points
	global	_digit0
	global	_digit1
	global	_divider
	global	_indexLines
	global	_status
	global	_INTCON
_INTCON	set	11
	global	_PORTB
_PORTB	set	6
	global	_PORTD
_PORTD	set	8
	global	_GIE
_GIE	set	95
	global	_RA0
_RA0	set	40
	global	_RA1
_RA1	set	41
	global	_RB4
_RB4	set	52
	global	_RB5
_RB5	set	53
	global	_T0IE
_T0IE	set	93
	global	_T0IF
_T0IF	set	90
	global	_TRISB
_TRISB	set	134
	global	_TRISD
_TRISD	set	136
	global	_PS0
_PS0	set	1032
	global	_PS1
_PS1	set	1033
	global	_PS2
_PS2	set	1034
	global	_PSA
_PSA	set	1035
	global	_T0CS
_T0CS	set	1037
	global	_ANSEL
_ANSEL	set	392
	global	_ANSELH
_ANSELH	set	393
	
STR_1:	
	retlw	87	;'W'
	retlw	101	;'e'
	retlw	108	;'l'
	retlw	99	;'c'
	retlw	111	;'o'
	retlw	109	;'m'
	retlw	101	;'e'
	retlw	0
psect	strings
	file	"SpaceMission.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssCOMMON,class=COMMON,space=1
global __pbssCOMMON
__pbssCOMMON:
_digit0:
       ds      1

_digit1:
       ds      1

_divider:
       ds      1

_indexLines:
       ds      1

_status:
       ds      1

psect	bssBANK0,class=BANK0,space=1
global __pbssBANK0
__pbssBANK0:
_points:
       ds      2

psect	dataBANK0,class=BANK0,space=1
global __pdataBANK0
__pdataBANK0:
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	31
_line0:
       ds      16

psect	dataBANK0
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	32
_line1:
       ds      16

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbssCOMMON)+0)&07Fh
	clrf	((__pbssCOMMON)+1)&07Fh
	clrf	((__pbssCOMMON)+2)&07Fh
	clrf	((__pbssCOMMON)+3)&07Fh
	clrf	((__pbssCOMMON)+4)&07Fh
; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2
	clrf	((__pbssBANK0)+0)&07Fh
	clrf	((__pbssBANK0)+1)&07Fh
global btemp
psect inittext,class=CODE,delta=2
global init_fetch,btemp
;	Called with low address in FSR and high address in W
init_fetch:
	movf btemp,w
	movwf pclath
	movf btemp+1,w
	movwf pc
global init_ram
;Called with:
;	high address of idata address in btemp 
;	low address of idata address in btemp+1 
;	low address of data in FSR
;	high address + 1 of data in btemp-1
init_ram:
	fcall init_fetch
	movwf indf,f
	incf fsr,f
	movf fsr,w
	xorwf btemp-1,w
	btfsc status,2
	retlw 0
	incf btemp+1,f
	btfsc status,2
	incf btemp,f
	goto init_ram
; Initialize objects allocated to BANK0
psect cinit,class=CODE,delta=2
global init_ram, __pidataBANK0
	bcf	status, 7	;select IRP bank0
	movlw low(__pdataBANK0+32)
	movwf btemp-1,f
	movlw high(__pidataBANK0)
	movwf btemp,f
	movlw low(__pidataBANK0)
	movwf btemp+1,f
	movlw low(__pdataBANK0)
	movwf fsr,f
	fcall init_ram
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_lcd_clear
?_lcd_clear:	; 0 bytes @ 0x0
	global	?_lcd_init
?_lcd_init:	; 0 bytes @ 0x0
	global	?_isr
?_isr:	; 0 bytes @ 0x0
	global	??_isr
??_isr:	; 0 bytes @ 0x0
	global	?_updateAsteroidsSpeed
?_updateAsteroidsSpeed:	; 0 bytes @ 0x0
	global	?_displayCountDown
?_displayCountDown:	; 0 bytes @ 0x0
	global	?_displayPoints
?_displayPoints:	; 0 bytes @ 0x0
	global	?_displaySpace
?_displaySpace:	; 0 bytes @ 0x0
	global	?_checkCollision
?_checkCollision:	; 0 bytes @ 0x0
	global	?_updateSpace
?_updateSpace:	; 0 bytes @ 0x0
	global	?_initCountDown
?_initCountDown:	; 0 bytes @ 0x0
	global	?_endMission
?_endMission:	; 0 bytes @ 0x0
	global	?_lcd_write
?_lcd_write:	; 0 bytes @ 0x0
	global	?_generateAsteroid
?_generateAsteroid:	; 1 bytes @ 0x0
	global	?_main
?_main:	; 2 bytes @ 0x0
	ds	5
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	??_updateAsteroidsSpeed
??_updateAsteroidsSpeed:	; 0 bytes @ 0x0
	global	??_displayCountDown
??_displayCountDown:	; 0 bytes @ 0x0
	global	??_displayPoints
??_displayPoints:	; 0 bytes @ 0x0
	global	??_generateAsteroid
??_generateAsteroid:	; 0 bytes @ 0x0
	global	??_checkCollision
??_checkCollision:	; 0 bytes @ 0x0
	global	??_updateSpace
??_updateSpace:	; 0 bytes @ 0x0
	global	??_initCountDown
??_initCountDown:	; 0 bytes @ 0x0
	global	??_endMission
??_endMission:	; 0 bytes @ 0x0
	global	??_lcd_write
??_lcd_write:	; 0 bytes @ 0x0
	ds	1
	global	updateSpace@prevIndex
updateSpace@prevIndex:	; 1 bytes @ 0x1
	ds	1
	global	lcd_write@c
lcd_write@c:	; 1 bytes @ 0x2
	ds	1
	global	??_lcd_clear
??_lcd_clear:	; 0 bytes @ 0x3
	global	?_lcd_puts
?_lcd_puts:	; 0 bytes @ 0x3
	global	lcd_puts@s
lcd_puts@s:	; 2 bytes @ 0x3
	ds	2
	global	??_lcd_puts
??_lcd_puts:	; 0 bytes @ 0x5
	global	??_lcd_init
??_lcd_init:	; 0 bytes @ 0x5
	global	??_displaySpace
??_displaySpace:	; 0 bytes @ 0x5
	ds	2
	global	lcd_init@init_value
lcd_init@init_value:	; 1 bytes @ 0x7
	ds	1
	global	??_main
??_main:	; 0 bytes @ 0x8
	ds	1
;;Data sizes: Strings 8, constant 10, data 32, bss 7, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      5      10
;; BANK0           80      9      43
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:

;; lcd_puts@s	PTR const unsigned char  size(2) Largest target is 16
;;		 -> STR_1(CODE[8]), line1(BANK0[16]), line0(BANK0[16]), 
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   None.
;;
;; Critical Paths under _isr in COMMON
;;
;;   None.
;;
;; Critical Paths under _main in BANK0
;;
;;   _main->_lcd_init
;;   _lcd_init->_lcd_clear
;;   _displaySpace->_lcd_clear
;;   _displaySpace->_lcd_puts
;;   _lcd_puts->_lcd_write
;;   _lcd_clear->_lcd_write
;;
;; Critical Paths under _isr in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _isr in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _isr in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.
;;
;; Critical Paths under _isr in BANK2
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 1, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 1     1      0     499
;;                                              8 BANK0      1     1      0
;;                           _lcd_init
;;                          _lcd_clear
;;                           _lcd_puts
;;                      _initCountDown
;;                        _updateSpace
;;                         _endMission
;;                   _displayCountDown
;;                      _displayPoints
;;                       _displaySpace
;;               _updateAsteroidsSpeed
;; ---------------------------------------------------------------------------------
;; (1) _lcd_init                                             3     3      0     122
;;                                              5 BANK0      3     3      0
;;                          _lcd_write
;;                          _lcd_clear
;; ---------------------------------------------------------------------------------
;; (1) _displaySpace                                         1     1      0     153
;;                          _lcd_clear
;;                           _lcd_puts
;; ---------------------------------------------------------------------------------
;; (2) _lcd_puts                                             2     0      2     109
;;                                              3 BANK0      2     0      2
;;                          _lcd_write
;; ---------------------------------------------------------------------------------
;; (2) _lcd_clear                                            2     2      0      44
;;                                              3 BANK0      2     2      0
;;                          _lcd_write
;; ---------------------------------------------------------------------------------
;; (3) _lcd_write                                            3     3      0      44
;;                                              0 BANK0      3     3      0
;; ---------------------------------------------------------------------------------
;; (1) _updateSpace                                          2     2      0      71
;;                                              0 BANK0      2     2      0
;;                   _generateAsteroid
;;                     _checkCollision
;; ---------------------------------------------------------------------------------
;; (1) _endMission                                           0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _initCountDown                                        0     0      0       0
;; ---------------------------------------------------------------------------------
;; (2) _checkCollision                                       0     0      0       0
;; ---------------------------------------------------------------------------------
;; (2) _generateAsteroid                                     0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _displayPoints                                        0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _displayCountDown                                     0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _updateAsteroidsSpeed                                 0     0      0       0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 3
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (4) _isr                                                  5     5      0       0
;;                                              0 COMMON     5     5      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 4
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _lcd_init
;;     _lcd_write
;;     _lcd_clear
;;       _lcd_write
;;   _lcd_clear
;;     _lcd_write
;;   _lcd_puts
;;     _lcd_write
;;   _initCountDown
;;   _updateSpace
;;     _generateAsteroid
;;     _checkCollision
;;   _endMission
;;   _displayCountDown
;;   _displayPoints
;;   _displaySpace
;;     _lcd_clear
;;       _lcd_write
;;     _lcd_puts
;;       _lcd_write
;;   _updateAsteroidsSpeed
;;
;; _isr (ROOT)
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BANK3               60      0       0       9        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;BANK2               60      0       0      11        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR1                 0      0       0       2        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;CODE                 0      0       0       0        0.0%
;;DATA                 0      0      38      12        0.0%
;;ABS                  0      0      35       3        0.0%
;;NULL                 0      0       0       0        0.0%
;;STACK                0      0       3       2        0.0%
;;BANK0               50      9      2B       5       53.8%
;;BITBANK0            50      0       0       4        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR0              0      0       0       1        0.0%
;;COMMON               E      5       A       1       71.4%
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 221 in file "C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  2  922[COMMON] int 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       1       0       0       0
;;      Totals:         0       1       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_lcd_init
;;		_lcd_clear
;;		_lcd_puts
;;		_initCountDown
;;		_updateSpace
;;		_endMission
;;		_displayCountDown
;;		_displayPoints
;;		_displaySpace
;;		_updateAsteroidsSpeed
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	221
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 4
; Regs used in _main: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	223
	
l3439:	
;spaceMission.c: 223: INTCON = 0;
	clrf	(11)	;volatile
	line	224
	
l3441:	
;spaceMission.c: 224: TRISB = 0b11000000;
	movlw	(0C0h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(134)^080h	;volatile
	line	225
	
l3443:	
;spaceMission.c: 225: ANSEL = 0b00000100;
	movlw	(04h)
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	movwf	(392)^0180h	;volatile
	line	226
;spaceMission.c: 226: ANSELH = 0x00;
	clrf	(393)^0180h	;volatile
	line	229
;spaceMission.c: 229: TRISD=0b00000000;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(136)^080h	;volatile
	line	231
	
l3445:	
;spaceMission.c: 231: lcd_init();
	fcall	_lcd_init
	line	232
	
l3447:	
;spaceMission.c: 232: lcd_clear();
	fcall	_lcd_clear
	line	233
	
l3449:	
;spaceMission.c: 233: lcd_puts("Welcome");
	movlw	low((STR_1-__stringbase))
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_lcd_puts)
	movlw	80h
	movwf	(?_lcd_puts+1)
	fcall	_lcd_puts
	line	234
	
l3451:	
;spaceMission.c: 234: initCountDown();
	fcall	_initCountDown
	line	236
	
l3453:	
;spaceMission.c: 236: GIE=1;
	bsf	(95/8),(95)&7
	goto	l3455
	line	239
;spaceMission.c: 239: while(1){
	
l923:	
	line	242
	
l3455:	
;spaceMission.c: 242: if (status & 0x8){
	btfss	(_status),(3)&7
	goto	u2551
	goto	u2550
u2551:
	goto	l3461
u2550:
	line	243
	
l3457:	
;spaceMission.c: 243: updateSpace();
	fcall	_updateSpace
	line	244
	
l3459:	
;spaceMission.c: 244: status &= ~0x8;
	movlw	(0F7h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	andwf	(_status),f
	goto	l3461
	line	245
	
l924:	
	line	247
	
l3461:	
;spaceMission.c: 245: }
;spaceMission.c: 247: if(status & 0x1 || status & 0x2 ){
	btfsc	(_status),(0)&7
	goto	u2561
	goto	u2560
u2561:
	goto	l3465
u2560:
	
l3463:	
	btfss	(_status),(1)&7
	goto	u2571
	goto	u2570
u2571:
	goto	l3467
u2570:
	goto	l3465
	
l927:	
	line	248
	
l3465:	
;spaceMission.c: 248: endMission();
	fcall	_endMission
	line	249
;spaceMission.c: 249: }else{
	goto	l3455
	
l925:	
	line	250
	
l3467:	
;spaceMission.c: 250: displayCountDown();
	fcall	_displayCountDown
	line	251
;spaceMission.c: 251: displayPoints();
	fcall	_displayPoints
	line	252
	
l3469:	
;spaceMission.c: 252: displaySpace();
	fcall	_displaySpace
	line	253
	
l3471:	
;spaceMission.c: 253: updateAsteroidsSpeed();
	fcall	_updateAsteroidsSpeed
	goto	l3455
	line	254
	
l928:	
	goto	l3455
	line	255
	
l929:	
	line	239
	goto	l3455
	
l930:	
	line	256
	
l931:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,90
	global	_lcd_init
psect	text435,local,class=CODE,delta=2
global __ptext435
__ptext435:

;; *************** function _lcd_init *****************
;; Defined at:
;;		line 93 in file "C:\Users\Michele\Documents\GitHub\spaceMission\lcd.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  init_value      1    7[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       1       0       0       0
;;      Temps:          0       2       0       0       0
;;      Totals:         0       3       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_lcd_write
;;		_lcd_clear
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text435
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\lcd.c"
	line	93
	global	__size_of_lcd_init
	__size_of_lcd_init	equ	__end_of_lcd_init-_lcd_init
	
_lcd_init:	
	opt	stack 4
; Regs used in _lcd_init: [wreg+status,2+status,0+pclath+cstack]
	line	96
	
l3399:	
;lcd.c: 94: char init_value;
;lcd.c: 96: init_value = 0x03;
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_lcd_init+0)+0
	movf	(??_lcd_init+0)+0,w
	movwf	(lcd_init@init_value)
	line	97
	
l3401:	
;lcd.c: 97: RB4 = 0;
	bcf	(52/8),(52)&7
	line	98
	
l3403:	
;lcd.c: 98: RB5 = 0;
	bcf	(53/8),(53)&7
	line	100
;lcd.c: 100: _delay((unsigned long)((15)*(8000000/4000.0)));
	opt asmopt_off
movlw	39
movwf	((??_lcd_init+0)+0+1),f
	movlw	245
movwf	((??_lcd_init+0)+0),f
u2587:
	decfsz	((??_lcd_init+0)+0),f
	goto	u2587
	decfsz	((??_lcd_init+0)+0+1),f
	goto	u2587
opt asmopt_on

	line	101
	
l3405:	
;lcd.c: 101: PORTB = (PORTB & 0xF0) | init_value;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(6),w
	andlw	0F0h
	iorwf	(lcd_init@init_value),w
	movwf	(6)	;volatile
	line	102
	
l3407:	
;lcd.c: 102: ((RB5 = 1),(RB5=0));
	bsf	(53/8),(53)&7
	
l3409:	
	bcf	(53/8),(53)&7
	line	103
	
l3411:	
;lcd.c: 103: _delay((unsigned long)((5)*(8000000/4000.0)));
	opt asmopt_off
movlw	13
movwf	((??_lcd_init+0)+0+1),f
	movlw	251
movwf	((??_lcd_init+0)+0),f
u2597:
	decfsz	((??_lcd_init+0)+0),f
	goto	u2597
	decfsz	((??_lcd_init+0)+0+1),f
	goto	u2597
	nop2
opt asmopt_on

	line	104
	
l3413:	
;lcd.c: 104: ((RB5 = 1),(RB5=0));
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(53/8),(53)&7
	
l3415:	
	bcf	(53/8),(53)&7
	line	105
	
l3417:	
;lcd.c: 105: PORTB = 0x02;
	movlw	(02h)
	movwf	(6)	;volatile
	line	106
	
l3419:	
;lcd.c: 106: ((RB5 = 1),(RB5=0));
	bsf	(53/8),(53)&7
	
l3421:	
	bcf	(53/8),(53)&7
	line	107
	
l3423:	
;lcd.c: 107: _delay((unsigned long)((5)*(8000000/4000.0)));
	opt asmopt_off
movlw	13
movwf	((??_lcd_init+0)+0+1),f
	movlw	251
movwf	((??_lcd_init+0)+0),f
u2607:
	decfsz	((??_lcd_init+0)+0),f
	goto	u2607
	decfsz	((??_lcd_init+0)+0+1),f
	goto	u2607
	nop2
opt asmopt_on

	line	108
	
l3425:	
;lcd.c: 108: ((RB5 = 1),(RB5=0));
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(53/8),(53)&7
	
l3427:	
	bcf	(53/8),(53)&7
	line	109
	
l3429:	
;lcd.c: 109: _delay((unsigned long)((5)*(8000000/4000.0)));
	opt asmopt_off
movlw	13
movwf	((??_lcd_init+0)+0+1),f
	movlw	251
movwf	((??_lcd_init+0)+0),f
u2617:
	decfsz	((??_lcd_init+0)+0),f
	goto	u2617
	decfsz	((??_lcd_init+0)+0+1),f
	goto	u2617
	nop2
opt asmopt_on

	line	111
	
l3431:	
;lcd.c: 111: lcd_write(0x28);
	movlw	(028h)
	fcall	_lcd_write
	line	112
	
l3433:	
;lcd.c: 112: lcd_write(0x0C);
	movlw	(0Ch)
	fcall	_lcd_write
	line	113
	
l3435:	
;lcd.c: 113: lcd_clear();
	fcall	_lcd_clear
	line	114
	
l3437:	
;lcd.c: 114: lcd_write(0x6);
	movlw	(06h)
	fcall	_lcd_write
	line	115
	
l1786:	
	return
	opt stack 0
GLOBAL	__end_of_lcd_init
	__end_of_lcd_init:
;; =============== function _lcd_init ends ============

	signat	_lcd_init,88
	global	_displaySpace
psect	text436,local,class=CODE,delta=2
global __ptext436
__ptext436:

;; *************** function _displaySpace *****************
;; Defined at:
;;		line 93 in file "C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  index           1    0        unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_lcd_clear
;;		_lcd_puts
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text436
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	93
	global	__size_of_displaySpace
	__size_of_displaySpace	equ	__end_of_displaySpace-_displaySpace
	
_displaySpace:	
	opt	stack 4
; Regs used in _displaySpace: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	96
	
l3393:	
;spaceMission.c: 94: unsigned char index;
;spaceMission.c: 96: lcd_clear();
	fcall	_lcd_clear
	line	97
	
l3395:	
;spaceMission.c: 97: lcd_puts(line0);
	movlw	(_line0&0ffh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_lcd_puts)
	movlw	(0x0/2)
	movwf	(?_lcd_puts+1)
	fcall	_lcd_puts
	line	98
	
l3397:	
;spaceMission.c: 98: lcd_puts(line1);
	movlw	(_line1&0ffh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_lcd_puts)
	movlw	(0x0/2)
	movwf	(?_lcd_puts+1)
	fcall	_lcd_puts
	line	106
	
l883:	
	return
	opt stack 0
GLOBAL	__end_of_displaySpace
	__end_of_displaySpace:
;; =============== function _displaySpace ends ============

	signat	_displaySpace,88
	global	_lcd_puts
psect	text437,local,class=CODE,delta=2
global __ptext437
__ptext437:

;; *************** function _lcd_puts *****************
;; Defined at:
;;		line 63 in file "C:\Users\Michele\Documents\GitHub\spaceMission\lcd.c"
;; Parameters:    Size  Location     Type
;;  s               2    3[BANK0 ] PTR const unsigned char 
;;		 -> STR_1(8), line1(16), line0(16), 
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       2       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       2       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_lcd_write
;; This function is called by:
;;		_displaySpace
;;		_main
;; This function uses a non-reentrant model
;;
psect	text437
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\lcd.c"
	line	63
	global	__size_of_lcd_puts
	__size_of_lcd_puts	equ	__end_of_lcd_puts-_lcd_puts
	
_lcd_puts:	
	opt	stack 4
; Regs used in _lcd_puts: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	64
	
l3385:	
;lcd.c: 64: RB4 = 1;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(52/8),(52)&7
	line	65
;lcd.c: 65: while(*s)
	goto	l3391
	
l1775:	
	line	66
	
l3387:	
;lcd.c: 66: lcd_write(*s++);
	movf	(lcd_puts@s+1),w
	movwf	btemp+1
	movf	(lcd_puts@s),w
	movwf	fsr0
	fcall	stringtab
	fcall	_lcd_write
	
l3389:	
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	addwf	(lcd_puts@s),f
	skipnc
	incf	(lcd_puts@s+1),f
	movlw	high(01h)
	addwf	(lcd_puts@s+1),f
	goto	l3391
	
l1774:	
	line	65
	
l3391:	
	movf	(lcd_puts@s+1),w
	movwf	btemp+1
	movf	(lcd_puts@s),w
	movwf	fsr0
	fcall	stringtab
	iorlw	0
	skipz
	goto	u2541
	goto	u2540
u2541:
	goto	l3387
u2540:
	goto	l1777
	
l1776:	
	line	67
	
l1777:	
	return
	opt stack 0
GLOBAL	__end_of_lcd_puts
	__end_of_lcd_puts:
;; =============== function _lcd_puts ends ============

	signat	_lcd_puts,4216
	global	_lcd_clear
psect	text438,local,class=CODE,delta=2
global __ptext438
__ptext438:

;; *************** function _lcd_clear *****************
;; Defined at:
;;		line 53 in file "C:\Users\Michele\Documents\GitHub\spaceMission\lcd.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       2       0       0       0
;;      Totals:         0       2       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_lcd_write
;; This function is called by:
;;		_displaySpace
;;		_main
;;		_lcd_init
;; This function uses a non-reentrant model
;;
psect	text438
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\lcd.c"
	line	53
	global	__size_of_lcd_clear
	__size_of_lcd_clear	equ	__end_of_lcd_clear-_lcd_clear
	
_lcd_clear:	
	opt	stack 4
; Regs used in _lcd_clear: [wreg+status,2+status,0+pclath+cstack]
	line	54
	
l3379:	
;lcd.c: 54: RB4 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(52/8),(52)&7
	line	55
	
l3381:	
;lcd.c: 55: lcd_write(0x1);
	movlw	(01h)
	fcall	_lcd_write
	line	56
	
l3383:	
;lcd.c: 56: _delay((unsigned long)((5)*(8000000/4000.0)));
	opt asmopt_off
movlw	13
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
movwf	((??_lcd_clear+0)+0+1),f
	movlw	251
movwf	((??_lcd_clear+0)+0),f
u2627:
	decfsz	((??_lcd_clear+0)+0),f
	goto	u2627
	decfsz	((??_lcd_clear+0)+0+1),f
	goto	u2627
	nop2
opt asmopt_on

	line	57
	
l1771:	
	return
	opt stack 0
GLOBAL	__end_of_lcd_clear
	__end_of_lcd_clear:
;; =============== function _lcd_clear ends ============

	signat	_lcd_clear,88
	global	_lcd_write
psect	text439,local,class=CODE,delta=2
global __ptext439
__ptext439:

;; *************** function _lcd_write *****************
;; Defined at:
;;		line 38 in file "C:\Users\Michele\Documents\GitHub\spaceMission\lcd.c"
;; Parameters:    Size  Location     Type
;;  c               1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  c               1    2[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       1       0       0       0
;;      Temps:          0       2       0       0       0
;;      Totals:         0       3       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_lcd_clear
;;		_lcd_puts
;;		_lcd_init
;;		_lcd_putch
;;		_lcd_goto
;; This function uses a non-reentrant model
;;
psect	text439
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\lcd.c"
	line	38
	global	__size_of_lcd_write
	__size_of_lcd_write	equ	__end_of_lcd_write-_lcd_write
	
_lcd_write:	
	opt	stack 4
; Regs used in _lcd_write: [wreg+status,2+status,0]
;lcd_write@c stored from wreg
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(lcd_write@c)
	line	39
	
l3365:	
;lcd.c: 39: _delay((unsigned long)((40)*(8000000/4000000.0)));
	opt asmopt_off
movlw	26
movwf	(??_lcd_write+0)+0,f
u2637:
decfsz	(??_lcd_write+0)+0,f
	goto	u2637
	clrwdt
opt asmopt_on

	line	40
	
l3367:	
;lcd.c: 40: PORTB = (PORTB & 0xF0) | ( ( c >> 4 ) & 0x0F );
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(lcd_write@c),w
	movwf	(??_lcd_write+0)+0
	movlw	04h
u2535:
	clrc
	rrf	(??_lcd_write+0)+0,f
	addlw	-1
	skipz
	goto	u2535
	movlw	(0Fh)
	andwf	0+(??_lcd_write+0)+0,w
	movwf	(??_lcd_write+1)+0
	movf	(6),w
	andlw	0F0h
	iorwf	0+(??_lcd_write+1)+0,w
	movwf	(6)	;volatile
	line	41
	
l3369:	
;lcd.c: 41: ((RB5 = 1),(RB5=0));
	bsf	(53/8),(53)&7
	
l3371:	
	bcf	(53/8),(53)&7
	line	42
	
l3373:	
;lcd.c: 42: PORTB = (PORTB & 0xF0) | (c & 0x0F);
	movlw	(0Fh)
	andwf	(lcd_write@c),w
	movwf	(??_lcd_write+0)+0
	movf	(6),w
	andlw	0F0h
	iorwf	0+(??_lcd_write+0)+0,w
	movwf	(6)	;volatile
	line	43
	
l3375:	
;lcd.c: 43: ((RB5 = 1),(RB5=0));
	bsf	(53/8),(53)&7
	
l3377:	
	bcf	(53/8),(53)&7
	line	44
;lcd.c: 44: _delay((unsigned long)((5)*(8000000/4000.0)));
	opt asmopt_off
movlw	13
movwf	((??_lcd_write+0)+0+1),f
	movlw	251
movwf	((??_lcd_write+0)+0),f
u2647:
	decfsz	((??_lcd_write+0)+0),f
	goto	u2647
	decfsz	((??_lcd_write+0)+0+1),f
	goto	u2647
	nop2
opt asmopt_on

	line	45
	
l1768:	
	return
	opt stack 0
GLOBAL	__end_of_lcd_write
	__end_of_lcd_write:
;; =============== function _lcd_write ends ============

	signat	_lcd_write,4216
	global	_updateSpace
psect	text440,local,class=CODE,delta=2
global __ptext440
__ptext440:

;; *************** function _updateSpace *****************
;; Defined at:
;;		line 126 in file "C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  prevIndex       1    1[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       1       0       0       0
;;      Temps:          0       1       0       0       0
;;      Totals:         0       2       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_generateAsteroid
;;		_checkCollision
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text440
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	126
	global	__size_of_updateSpace
	__size_of_updateSpace	equ	__end_of_updateSpace-_updateSpace
	
_updateSpace:	
	opt	stack 5
; Regs used in _updateSpace: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	132
	
l3327:	
;spaceMission.c: 132: if(line0[indexLines] == 'B' || line1[indexLines] == 'B'){
	movf	(_indexLines),w
	addlw	_line0&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	xorlw	042h
	skipnz
	goto	u2451
	goto	u2450
u2451:
	goto	l3331
u2450:
	
l3329:	
	movf	(_indexLines),w
	addlw	_line1&0ffh
	movwf	fsr0
	movf	indf,w
	xorlw	042h
	skipz
	goto	u2461
	goto	u2460
u2461:
	goto	l3333
u2460:
	goto	l3331
	
l896:	
	line	133
	
l3331:	
;spaceMission.c: 133: ++points;
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	addwf	(_points),f
	skipnc
	incf	(_points+1),f
	movlw	high(01h)
	addwf	(_points+1),f
	goto	l3333
	line	134
	
l894:	
	line	139
	
l3333:	
;spaceMission.c: 134: }
;spaceMission.c: 139: unsigned char prevIndex = 0;
	clrc
	movlw	0
	btfsc	status,0
	movlw	1
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(updateSpace@prevIndex)
	line	141
	
l3335:	
;spaceMission.c: 141: if (indexLines !=0){
	movf	(_indexLines),w
	skipz
	goto	u2470
	goto	l3339
u2470:
	line	142
	
l3337:	
;spaceMission.c: 142: prevIndex = indexLines-1;
	movf	(_indexLines),w
	addlw	0FFh
	movwf	(??_updateSpace+0)+0
	movf	(??_updateSpace+0)+0,w
	movwf	(updateSpace@prevIndex)
	line	143
;spaceMission.c: 143: } else {
	goto	l3341
	
l897:	
	line	144
	
l3339:	
;spaceMission.c: 144: prevIndex = 15;
	movlw	(0Fh)
	movwf	(??_updateSpace+0)+0
	movf	(??_updateSpace+0)+0,w
	movwf	(updateSpace@prevIndex)
	goto	l3341
	line	145
	
l898:	
	line	147
	
l3341:	
;spaceMission.c: 145: }
;spaceMission.c: 147: if (generateAsteroid()){
	fcall	_generateAsteroid
	xorlw	0
	skipnz
	goto	u2481
	goto	u2480
u2481:
	goto	l3349
u2480:
	line	148
	
l3343:	
;spaceMission.c: 148: if(line1[prevIndex] != 'B'){
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(updateSpace@prevIndex),w
	addlw	_line1&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	xorlw	042h
	skipnz
	goto	u2491
	goto	u2490
u2491:
	goto	l3347
u2490:
	line	149
	
l3345:	
;spaceMission.c: 149: line0[indexLines] = 'B';
	movlw	(042h)
	movwf	(??_updateSpace+0)+0
	movf	(_indexLines),w
	addlw	_line0&0ffh
	movwf	fsr0
	movf	(??_updateSpace+0)+0,w
	movwf	indf
	line	150
;spaceMission.c: 150: } else {
	goto	l901
	
l900:	
	line	151
	
l3347:	
;spaceMission.c: 151: line0[indexLines] = 'A';
	movlw	(041h)
	movwf	(??_updateSpace+0)+0
	movf	(_indexLines),w
	addlw	_line0&0ffh
	movwf	fsr0
	movf	(??_updateSpace+0)+0,w
	movwf	indf
	line	152
	
l901:	
	line	153
;spaceMission.c: 152: }
;spaceMission.c: 153: line1[indexLines] = 'A';
	movlw	(041h)
	movwf	(??_updateSpace+0)+0
	movf	(_indexLines),w
	addlw	_line1&0ffh
	movwf	fsr0
	movf	(??_updateSpace+0)+0,w
	movwf	indf
	line	155
;spaceMission.c: 155: }else if(generateAsteroid()){
	goto	l3359
	
l899:	
	
l3349:	
	fcall	_generateAsteroid
	xorlw	0
	skipnz
	goto	u2501
	goto	u2500
u2501:
	goto	l3357
u2500:
	line	156
	
l3351:	
;spaceMission.c: 156: if(line0[prevIndex] != 'B'){
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(updateSpace@prevIndex),w
	addlw	_line0&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	xorlw	042h
	skipnz
	goto	u2511
	goto	u2510
u2511:
	goto	l3355
u2510:
	line	157
	
l3353:	
;spaceMission.c: 157: line1[indexLines] = 'B';
	movlw	(042h)
	movwf	(??_updateSpace+0)+0
	movf	(_indexLines),w
	addlw	_line1&0ffh
	movwf	fsr0
	movf	(??_updateSpace+0)+0,w
	movwf	indf
	line	158
;spaceMission.c: 158: } else {
	goto	l905
	
l904:	
	line	159
	
l3355:	
;spaceMission.c: 159: line1[indexLines] = 'A';
	movlw	(041h)
	movwf	(??_updateSpace+0)+0
	movf	(_indexLines),w
	addlw	_line1&0ffh
	movwf	fsr0
	movf	(??_updateSpace+0)+0,w
	movwf	indf
	line	160
	
l905:	
	line	161
;spaceMission.c: 160: }
;spaceMission.c: 161: line0[indexLines] = 'A';
	movlw	(041h)
	movwf	(??_updateSpace+0)+0
	movf	(_indexLines),w
	addlw	_line0&0ffh
	movwf	fsr0
	movf	(??_updateSpace+0)+0,w
	movwf	indf
	line	162
;spaceMission.c: 162: } else {
	goto	l3359
	
l903:	
	line	164
	
l3357:	
;spaceMission.c: 164: line0[indexLines] = 'A';
	movlw	(041h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_updateSpace+0)+0
	movf	(_indexLines),w
	addlw	_line0&0ffh
	movwf	fsr0
	movf	(??_updateSpace+0)+0,w
	bcf	status, 7	;select IRP bank0
	movwf	indf
	line	165
;spaceMission.c: 165: line1[indexLines] = 'A';
	movlw	(041h)
	movwf	(??_updateSpace+0)+0
	movf	(_indexLines),w
	addlw	_line1&0ffh
	movwf	fsr0
	movf	(??_updateSpace+0)+0,w
	movwf	indf
	goto	l3359
	line	166
	
l906:	
	goto	l3359
	
l902:	
	line	169
	
l3359:	
;spaceMission.c: 166: }
;spaceMission.c: 169: if (++indexLines > 15){
	movlw	(01h)
	movwf	(??_updateSpace+0)+0
	movf	(??_updateSpace+0)+0,w
	addwf	(_indexLines),f
	movlw	(010h)
	subwf	((_indexLines)),w
	skipc
	goto	u2521
	goto	u2520
u2521:
	goto	l3363
u2520:
	line	170
	
l3361:	
;spaceMission.c: 170: indexLines = 0;
	clrc
	movlw	0
	btfsc	status,0
	movlw	1
	movwf	(_indexLines)
	goto	l3363
	line	171
	
l907:	
	line	174
	
l3363:	
;spaceMission.c: 171: }
;spaceMission.c: 174: checkCollision();
	fcall	_checkCollision
	line	179
	
l908:	
	return
	opt stack 0
GLOBAL	__end_of_updateSpace
	__end_of_updateSpace:
;; =============== function _updateSpace ends ============

	signat	_updateSpace,88
	global	_endMission
psect	text441,local,class=CODE,delta=2
global __ptext441
__ptext441:

;; *************** function _endMission *****************
;; Defined at:
;;		line 215 in file "C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text441
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	215
	global	__size_of_endMission
	__size_of_endMission	equ	__end_of_endMission-_endMission
	
_endMission:	
	opt	stack 6
; Regs used in _endMission: []
	line	217
	
l920:	
	return
	opt stack 0
GLOBAL	__end_of_endMission
	__end_of_endMission:
;; =============== function _endMission ends ============

	signat	_endMission,88
	global	_initCountDown
psect	text442,local,class=CODE,delta=2
global __ptext442
__ptext442:

;; *************** function _initCountDown *****************
;; Defined at:
;;		line 201 in file "C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text442
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	201
	global	__size_of_initCountDown
	__size_of_initCountDown	equ	__end_of_initCountDown-_initCountDown
	
_initCountDown:	
	opt	stack 6
; Regs used in _initCountDown: [wreg+status,2+status,0]
	line	203
	
l3315:	
;spaceMission.c: 203: T0CS=0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1037/8)^080h,(1037)&7
	line	204
;spaceMission.c: 204: PSA=0;
	bcf	(1035/8)^080h,(1035)&7
	line	206
;spaceMission.c: 206: PS2=1; PS1=1; PS0=1;
	bsf	(1034/8)^080h,(1034)&7
	bsf	(1033/8)^080h,(1033)&7
	bsf	(1032/8)^080h,(1032)&7
	line	208
;spaceMission.c: 208: T0IF=0;
	bcf	(90/8),(90)&7
	line	209
;spaceMission.c: 209: T0IE=1;
	bsf	(93/8),(93)&7
	line	211
	
l3317:	
;spaceMission.c: 211: divider=0;
	clrc
	movlw	0
	btfsc	status,0
	movlw	1
	movwf	(_divider)
	line	212
	
l917:	
	return
	opt stack 0
GLOBAL	__end_of_initCountDown
	__end_of_initCountDown:
;; =============== function _initCountDown ends ============

	signat	_initCountDown,88
	global	_checkCollision
psect	text443,local,class=CODE,delta=2
global __ptext443
__ptext443:

;; *************** function _checkCollision *****************
;; Defined at:
;;		line 112 in file "C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_updateSpace
;; This function uses a non-reentrant model
;;
psect	text443
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	112
	global	__size_of_checkCollision
	__size_of_checkCollision	equ	__end_of_checkCollision-_checkCollision
	
_checkCollision:	
	opt	stack 5
; Regs used in _checkCollision: [wreg-fsr0h+status,2+status,0]
	line	116
	
l3309:	
	goto	l891
	
l3311:	
	goto	l891
	line	118
	
l889:	
	line	119
	goto	l891
	
l3313:	
	goto	l891
	line	121
	
l890:	
	line	122
	
l891:	
	return
	opt stack 0
GLOBAL	__end_of_checkCollision
	__end_of_checkCollision:
;; =============== function _checkCollision ends ============

	signat	_checkCollision,88
	global	_generateAsteroid
psect	text444,local,class=CODE,delta=2
global __ptext444
__ptext444:

;; *************** function _generateAsteroid *****************
;; Defined at:
;;		line 108 in file "C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_updateSpace
;; This function uses a non-reentrant model
;;
psect	text444
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	108
	global	__size_of_generateAsteroid
	__size_of_generateAsteroid	equ	__end_of_generateAsteroid-_generateAsteroid
	
_generateAsteroid:	
	opt	stack 5
; Regs used in _generateAsteroid: [wreg]
	line	109
	
l3305:	
;spaceMission.c: 109: return 1;
	movlw	(01h)
	goto	l886
	
l3307:	
	line	110
	
l886:	
	return
	opt stack 0
GLOBAL	__end_of_generateAsteroid
	__end_of_generateAsteroid:
;; =============== function _generateAsteroid ends ============

	signat	_generateAsteroid,89
	global	_displayPoints
psect	text445,local,class=CODE,delta=2
global __ptext445
__ptext445:

;; *************** function _displayPoints *****************
;; Defined at:
;;		line 89 in file "C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text445
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	89
	global	__size_of_displayPoints
	__size_of_displayPoints	equ	__end_of_displayPoints-_displayPoints
	
_displayPoints:	
	opt	stack 6
; Regs used in _displayPoints: []
	line	91
	
l880:	
	return
	opt stack 0
GLOBAL	__end_of_displayPoints
	__end_of_displayPoints:
;; =============== function _displayPoints ends ============

	signat	_displayPoints,88
	global	_displayCountDown
psect	text446,local,class=CODE,delta=2
global __ptext446
__ptext446:

;; *************** function _displayCountDown *****************
;; Defined at:
;;		line 85 in file "C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text446
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	85
	global	__size_of_displayCountDown
	__size_of_displayCountDown	equ	__end_of_displayCountDown-_displayCountDown
	
_displayCountDown:	
	opt	stack 6
; Regs used in _displayCountDown: []
	line	87
	
l877:	
	return
	opt stack 0
GLOBAL	__end_of_displayCountDown
	__end_of_displayCountDown:
;; =============== function _displayCountDown ends ============

	signat	_displayCountDown,88
	global	_updateAsteroidsSpeed
psect	text447,local,class=CODE,delta=2
global __ptext447
__ptext447:

;; *************** function _updateAsteroidsSpeed *****************
;; Defined at:
;;		line 79 in file "C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text447
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	79
	global	__size_of_updateAsteroidsSpeed
	__size_of_updateAsteroidsSpeed	equ	__end_of_updateAsteroidsSpeed-_updateAsteroidsSpeed
	
_updateAsteroidsSpeed:	
	opt	stack 6
; Regs used in _updateAsteroidsSpeed: []
	line	83
	
l874:	
	return
	opt stack 0
GLOBAL	__end_of_updateAsteroidsSpeed
	__end_of_updateAsteroidsSpeed:
;; =============== function _updateAsteroidsSpeed ends ============

	signat	_updateAsteroidsSpeed,88
	global	_isr
psect	text448,local,class=CODE,delta=2
global __ptext448
__ptext448:

;; *************** function _isr *****************
;; Defined at:
;;		line 40 in file "C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          5       0       0       0       0
;;      Totals:         5       0       0       0       0
;;Total ram usage:        5 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		Interrupt level 1
;; This function uses a non-reentrant model
;;
psect	text448
	file	"C:\Users\Michele\Documents\GitHub\spaceMission\spaceMission.c"
	line	40
	global	__size_of_isr
	__size_of_isr	equ	__end_of_isr-_isr
	
_isr:	
	opt	stack 4
; Regs used in _isr: [wreg+status,2+status,0]
psect	intentry,class=CODE,delta=2
global __pintentry
__pintentry:
global interrupt_function
interrupt_function:
	global saved_w
	saved_w	set	btemp+0
	movwf	saved_w
	movf	status,w
	movwf	(??_isr+1)
	movf	fsr0,w
	movwf	(??_isr+2)
	movf	pclath,w
	movwf	(??_isr+3)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	btemp+1,w
	movwf	(??_isr+4)
	ljmp	_isr
psect	text448
	line	42
	
i1l2159:	
;spaceMission.c: 42: GIE=0;
	bcf	(95/8),(95)&7
	line	49
;spaceMission.c: 49: if (T0IF == 1){
	btfss	(90/8),(90)&7
	goto	u1_21
	goto	u1_20
u1_21:
	goto	i1l2183
u1_20:
	line	50
	
i1l2161:	
;spaceMission.c: 50: T0IF=0;
	bcf	(90/8),(90)&7
	line	51
	
i1l2163:	
;spaceMission.c: 51: if (divider==25){
	movf	(_divider),w
	xorlw	019h
	skipz
	goto	u2_21
	goto	u2_20
u2_21:
	goto	i1l2181
u2_20:
	line	52
	
i1l2165:	
;spaceMission.c: 52: divider=0;
	clrc
	movlw	0
	btfsc	status,0
	movlw	1
	movwf	(_divider)
	line	53
	
i1l2167:	
;spaceMission.c: 53: status |= 0x8;
	bsf	(_status)+(3/8),(3)&7
	line	54
	
i1l2169:	
;spaceMission.c: 54: if(digit0 == 0){
	movf	(_digit0),f
	skipz
	goto	u3_21
	goto	u3_20
u3_21:
	goto	i1l2179
u3_20:
	line	55
	
i1l2171:	
;spaceMission.c: 55: if(digit1 == 0){
	movf	(_digit1),f
	skipz
	goto	u4_21
	goto	u4_20
u4_21:
	goto	i1l2175
u4_20:
	goto	i1l2183
	line	58
	
i1l2173:	
;spaceMission.c: 58: }else{
	goto	i1l2183
	
i1l862:	
	line	60
	
i1l2175:	
;spaceMission.c: 60: digit1--;
	movlw	low(01h)
	subwf	(_digit1),f
	line	61
	
i1l2177:	
;spaceMission.c: 61: digit0 = 9;
	movlw	(09h)
	movwf	(??_isr+0)+0
	movf	(??_isr+0)+0,w
	movwf	(_digit0)
	goto	i1l2183
	line	62
	
i1l863:	
	line	63
;spaceMission.c: 62: }
;spaceMission.c: 63: }else
	goto	i1l2183
	
i1l861:	
	line	64
	
i1l2179:	
;spaceMission.c: 64: digit0--;
	movlw	low(01h)
	subwf	(_digit0),f
	goto	i1l2183
	
i1l864:	
	line	65
;spaceMission.c: 65: }
	goto	i1l2183
	line	66
	
i1l860:	
	line	67
	
i1l2181:	
;spaceMission.c: 66: else
;spaceMission.c: 67: divider++;
	movlw	(01h)
	movwf	(??_isr+0)+0
	movf	(??_isr+0)+0,w
	addwf	(_divider),f
	goto	i1l2183
	
i1l865:	
	goto	i1l2183
	line	68
	
i1l859:	
	line	69
	
i1l2183:	
;spaceMission.c: 68: }
;spaceMission.c: 69: GIE=1;
	bsf	(95/8),(95)&7
	line	70
	
i1l866:	
	movf	(??_isr+4),w
	movwf	btemp+1
	movf	(??_isr+3),w
	movwf	pclath
	movf	(??_isr+2),w
	movwf	fsr0
	movf	(??_isr+1),w
	movwf	status
	swapf	saved_w,f
	swapf	saved_w,w
	retfie
	opt stack 0
GLOBAL	__end_of_isr
	__end_of_isr:
;; =============== function _isr ends ============

	signat	_isr,88
psect	text449,local,class=CODE,delta=2
global __ptext449
__ptext449:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
