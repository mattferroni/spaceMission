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
# 2 "C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
	psect config,class=CONFIG,delta=2 ;#
# 2 "C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
	dw 0x23E2 ;#
	FNCALL	_main,_initCountDown
	FNCALL	_main,_endMission
	FNCALL	_main,_updateCountDown
	FNCALL	_main,_updatePoints
	FNCALL	_main,_updateSpace
	FNCALL	_main,_updateAsteroidsSpeed
	FNCALL	_updateCountDown,_sleep
	FNROOT	_main
	FNCALL	intlevel1,_isr
	global	intlevel1
	FNROOT	intlevel1
	global	_map
psect	strings,class=STRING,delta=2
global __pstrings
__pstrings:
;	global	stringdir,stringtab,__stringbase
stringtab:
;	String table - string pointers are 1 byte each
stringcode:stringdir:
movlw high(stringdir)
movwf pclath
movf fsr,w
incf fsr
	addwf pc
__stringbase:
	retlw	0
psect	strings
	file	"C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
	line	7
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
	global	_collision
	global	_digit0
	global	_digit1
	global	_endGame
	global	_divider
	global	_PORTD
_PORTD	set	8
	global	_GIE
_GIE	set	95
	global	_RA0
_RA0	set	40
	global	_RA1
_RA1	set	41
	global	_T0IE
_T0IE	set	93
	global	_T0IF
_T0IF	set	90
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
	file	"SpaceMission.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssCOMMON,class=COMMON,space=1
global __pbssCOMMON
__pbssCOMMON:
_digit0:
       ds      2

_digit1:
       ds      2

_endGame:
       ds      2

_divider:
       ds      1

psect	bssBANK0,class=BANK0,space=1
global __pbssBANK0
__pbssBANK0:
_collision:
       ds      2

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbssCOMMON)+0)&07Fh
	clrf	((__pbssCOMMON)+1)&07Fh
	clrf	((__pbssCOMMON)+2)&07Fh
	clrf	((__pbssCOMMON)+3)&07Fh
	clrf	((__pbssCOMMON)+4)&07Fh
	clrf	((__pbssCOMMON)+5)&07Fh
	clrf	((__pbssCOMMON)+6)&07Fh
; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2
	clrf	((__pbssBANK0)+0)&07Fh
	clrf	((__pbssBANK0)+1)&07Fh
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_initCountDown
?_initCountDown:	; 0 bytes @ 0x0
	global	?_endMission
?_endMission:	; 0 bytes @ 0x0
	global	?_updateCountDown
?_updateCountDown:	; 0 bytes @ 0x0
	global	?_updatePoints
?_updatePoints:	; 0 bytes @ 0x0
	global	?_updateSpace
?_updateSpace:	; 0 bytes @ 0x0
	global	?_updateAsteroidsSpeed
?_updateAsteroidsSpeed:	; 0 bytes @ 0x0
	global	?_sleep
?_sleep:	; 0 bytes @ 0x0
	global	?_isr
?_isr:	; 0 bytes @ 0x0
	global	??_isr
??_isr:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 2 bytes @ 0x0
	ds	5
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	??_initCountDown
??_initCountDown:	; 0 bytes @ 0x0
	global	??_endMission
??_endMission:	; 0 bytes @ 0x0
	global	??_updatePoints
??_updatePoints:	; 0 bytes @ 0x0
	global	??_updateSpace
??_updateSpace:	; 0 bytes @ 0x0
	global	??_updateAsteroidsSpeed
??_updateAsteroidsSpeed:	; 0 bytes @ 0x0
	global	??_sleep
??_sleep:	; 0 bytes @ 0x0
	global	sleep@i
sleep@i:	; 2 bytes @ 0x0
	ds	2
	global	??_updateCountDown
??_updateCountDown:	; 0 bytes @ 0x2
	global	??_main
??_main:	; 0 bytes @ 0x2
;;Data sizes: Strings 0, constant 10, data 0, bss 9, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      5      12
;; BANK0           80      2       4
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:



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
;;   _updateCountDown->_sleep
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
;;Main: autosize = 0, tempsize = 0, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 0     0      0      68
;;                      _initCountDown
;;                         _endMission
;;                    _updateCountDown
;;                       _updatePoints
;;                        _updateSpace
;;               _updateAsteroidsSpeed
;; ---------------------------------------------------------------------------------
;; (1) _updateCountDown                                      0     0      0      68
;;                              _sleep
;; ---------------------------------------------------------------------------------
;; (2) _sleep                                                2     2      0      68
;;                                              0 BANK0      2     2      0
;; ---------------------------------------------------------------------------------
;; (1) _updateAsteroidsSpeed                                 0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _updateSpace                                          0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _updatePoints                                         0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _endMission                                           0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _initCountDown                                        0     0      0       0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 2
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (3) _isr                                                  5     5      0       0
;;                                              0 COMMON     5     5      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 3
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _initCountDown
;;   _endMission
;;   _updateCountDown
;;     _sleep
;;   _updatePoints
;;   _updateSpace
;;   _updateAsteroidsSpeed
;;
;; _isr (ROOT)
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      5       C       1       85.7%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       2       2        0.0%
;;ABS                  0      0      10       3        0.0%
;;BITBANK0            50      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BANK0               50      2       4       5        5.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;BANK3               60      0       0       9        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;BANK2               60      0       0      11        0.0%
;;DATA                 0      0      12      12        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 63 in file "C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  2  870[COMMON] int 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_initCountDown
;;		_endMission
;;		_updateCountDown
;;		_updatePoints
;;		_updateSpace
;;		_updateAsteroidsSpeed
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
	line	63
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 5
; Regs used in _main: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	65
	
l2202:	
;spaceMission.c: 65: ANSEL=0x00;
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	clrf	(392)^0180h	;volatile
	line	66
;spaceMission.c: 66: ANSELH=0x00;
	clrf	(393)^0180h	;volatile
	line	68
;spaceMission.c: 68: TRISD=0b00000000;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(136)^080h	;volatile
	line	70
	
l2204:	
;spaceMission.c: 70: initCountDown();
	fcall	_initCountDown
	line	72
	
l2206:	
;spaceMission.c: 72: GIE=1;
	bsf	(95/8),(95)&7
	goto	l2208
	line	75
;spaceMission.c: 75: while(1){
	
l871:	
	line	78
	
l2208:	
;spaceMission.c: 78: if(endGame == 0 || collision == 1){
	movf	(_endGame+1),w
	iorwf	(_endGame),w
	skipnz
	goto	u2281
	goto	u2280
u2281:
	goto	l2212
u2280:
	
l2210:	
	movlw	01h
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	xorwf	(_collision),w
	iorwf	(_collision+1),w
	skipz
	goto	u2291
	goto	u2290
u2291:
	goto	l2214
u2290:
	goto	l2212
	
l874:	
	line	79
	
l2212:	
;spaceMission.c: 79: endMission();
	fcall	_endMission
	line	80
;spaceMission.c: 80: }else{
	goto	l2208
	
l872:	
	line	81
	
l2214:	
;spaceMission.c: 81: updateCountDown();
	fcall	_updateCountDown
	line	82
	
l2216:	
;spaceMission.c: 82: updatePoints();
	fcall	_updatePoints
	line	83
	
l2218:	
;spaceMission.c: 83: updateSpace();
	fcall	_updateSpace
	line	84
	
l2220:	
;spaceMission.c: 84: updateAsteroidsSpeed();
	fcall	_updateAsteroidsSpeed
	goto	l2208
	line	85
	
l875:	
	goto	l2208
	line	86
	
l876:	
	line	75
	goto	l2208
	
l877:	
	line	87
	
l878:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,90
	global	_updateCountDown
psect	text257,local,class=CODE,delta=2
global __ptext257
__ptext257:

;; *************** function _updateCountDown *****************
;; Defined at:
;;		line 124 in file "C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
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
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_sleep
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text257
	file	"C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
	line	124
	global	__size_of_updateCountDown
	__size_of_updateCountDown	equ	__end_of_updateCountDown-_updateCountDown
	
_updateCountDown:	
	opt	stack 5
; Regs used in _updateCountDown: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	126
	
l2188:	
;spaceMission.c: 126: PORTD = map[digit0];
	movf	(_digit0),w
	addlw	low((_map-__stringbase))
	movwf	fsr0
	fcall	stringdir
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(8)	;volatile
	line	127
	
l2190:	
;spaceMission.c: 127: RA0=1;
	bsf	(40/8),(40)&7
	line	128
	
l2192:	
;spaceMission.c: 128: sleep();
	fcall	_sleep
	line	129
	
l2194:	
;spaceMission.c: 129: RA0=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(40/8),(40)&7
	line	131
	
l2196:	
;spaceMission.c: 131: PORTD = map[digit1];
	movf	(_digit1),w
	addlw	low((_map-__stringbase))
	movwf	fsr0
	fcall	stringdir
	movwf	(8)	;volatile
	line	132
	
l2198:	
;spaceMission.c: 132: RA1=1;
	bsf	(41/8),(41)&7
	line	133
;spaceMission.c: 133: sleep();
	fcall	_sleep
	line	134
	
l2200:	
;spaceMission.c: 134: RA1=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(41/8),(41)&7
	line	135
	
l890:	
	return
	opt stack 0
GLOBAL	__end_of_updateCountDown
	__end_of_updateCountDown:
;; =============== function _updateCountDown ends ============

	signat	_updateCountDown,88
	global	_sleep
psect	text258,local,class=CODE,delta=2
global __ptext258
__ptext258:

;; *************** function _sleep *****************
;; Defined at:
;;		line 137 in file "C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  i               2    0[BANK0 ] int 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, btemp+1
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       2       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       2       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_updateCountDown
;; This function uses a non-reentrant model
;;
psect	text258
	file	"C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
	line	137
	global	__size_of_sleep
	__size_of_sleep	equ	__end_of_sleep-_sleep
	
_sleep:	
	opt	stack 5
; Regs used in _sleep: [wreg+btemp+1]
	line	138
	
l2178:	
;spaceMission.c: 138: for(int i = 0; i < 256; i++);
	movlw	low(0)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(sleep@i)
	movlw	high(0)
	movwf	((sleep@i))+1
	
l2180:	
	movf	(sleep@i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(0100h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2265
	movlw	low(0100h)
	subwf	(sleep@i),w
u2265:

	skipc
	goto	u2261
	goto	u2260
u2261:
	goto	l2184
u2260:
	goto	l895
	
l2182:	
	goto	l895
	
l893:	
	
l2184:	
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	addwf	(sleep@i),f
	skipnc
	incf	(sleep@i+1),f
	movlw	high(01h)
	addwf	(sleep@i+1),f
	
l2186:	
	movf	(sleep@i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(0100h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2275
	movlw	low(0100h)
	subwf	(sleep@i),w
u2275:

	skipc
	goto	u2271
	goto	u2270
u2271:
	goto	l2184
u2270:
	goto	l895
	
l894:	
	line	139
	
l895:	
	return
	opt stack 0
GLOBAL	__end_of_sleep
	__end_of_sleep:
;; =============== function _sleep ends ============

	signat	_sleep,88
	global	_updateAsteroidsSpeed
psect	text259,local,class=CODE,delta=2
global __ptext259
__ptext259:

;; *************** function _updateAsteroidsSpeed *****************
;; Defined at:
;;		line 90 in file "C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
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
psect	text259
	file	"C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
	line	90
	global	__size_of_updateAsteroidsSpeed
	__size_of_updateAsteroidsSpeed	equ	__end_of_updateAsteroidsSpeed-_updateAsteroidsSpeed
	
_updateAsteroidsSpeed:	
	opt	stack 6
; Regs used in _updateAsteroidsSpeed: []
	line	94
	
l881:	
	return
	opt stack 0
GLOBAL	__end_of_updateAsteroidsSpeed
	__end_of_updateAsteroidsSpeed:
;; =============== function _updateAsteroidsSpeed ends ============

	signat	_updateAsteroidsSpeed,88
	global	_updateSpace
psect	text260,local,class=CODE,delta=2
global __ptext260
__ptext260:

;; *************** function _updateSpace *****************
;; Defined at:
;;		line 97 in file "C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
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
psect	text260
	file	"C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
	line	97
	global	__size_of_updateSpace
	__size_of_updateSpace	equ	__end_of_updateSpace-_updateSpace
	
_updateSpace:	
	opt	stack 6
; Regs used in _updateSpace: []
	line	116
	
l884:	
	return
	opt stack 0
GLOBAL	__end_of_updateSpace
	__end_of_updateSpace:
;; =============== function _updateSpace ends ============

	signat	_updateSpace,88
	global	_updatePoints
psect	text261,local,class=CODE,delta=2
global __ptext261
__ptext261:

;; *************** function _updatePoints *****************
;; Defined at:
;;		line 119 in file "C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
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
psect	text261
	file	"C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
	line	119
	global	__size_of_updatePoints
	__size_of_updatePoints	equ	__end_of_updatePoints-_updatePoints
	
_updatePoints:	
	opt	stack 6
; Regs used in _updatePoints: []
	line	121
	
l887:	
	return
	opt stack 0
GLOBAL	__end_of_updatePoints
	__end_of_updatePoints:
;; =============== function _updatePoints ends ============

	signat	_updatePoints,88
	global	_endMission
psect	text262,local,class=CODE,delta=2
global __ptext262
__ptext262:

;; *************** function _endMission *****************
;; Defined at:
;;		line 154 in file "C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
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
psect	text262
	file	"C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
	line	154
	global	__size_of_endMission
	__size_of_endMission	equ	__end_of_endMission-_endMission
	
_endMission:	
	opt	stack 6
; Regs used in _endMission: []
	line	156
	
l901:	
	return
	opt stack 0
GLOBAL	__end_of_endMission
	__end_of_endMission:
;; =============== function _endMission ends ============

	signat	_endMission,88
	global	_initCountDown
psect	text263,local,class=CODE,delta=2
global __ptext263
__ptext263:

;; *************** function _initCountDown *****************
;; Defined at:
;;		line 140 in file "C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
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
psect	text263
	file	"C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
	line	140
	global	__size_of_initCountDown
	__size_of_initCountDown	equ	__end_of_initCountDown-_initCountDown
	
_initCountDown:	
	opt	stack 6
; Regs used in _initCountDown: [wreg+status,2+status,0]
	line	142
	
l2174:	
;spaceMission.c: 142: T0CS=0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1037/8)^080h,(1037)&7
	line	143
;spaceMission.c: 143: PSA=0;
	bcf	(1035/8)^080h,(1035)&7
	line	145
;spaceMission.c: 145: PS2=1; PS1=1; PS0=1;
	bsf	(1034/8)^080h,(1034)&7
	bsf	(1033/8)^080h,(1033)&7
	bsf	(1032/8)^080h,(1032)&7
	line	147
;spaceMission.c: 147: T0IF=0;
	bcf	(90/8),(90)&7
	line	148
;spaceMission.c: 148: T0IE=1;
	bsf	(93/8),(93)&7
	line	150
	
l2176:	
;spaceMission.c: 150: divider=0;
	clrc
	movlw	0
	btfsc	status,0
	movlw	1
	movwf	(_divider)
	line	151
	
l898:	
	return
	opt stack 0
GLOBAL	__end_of_initCountDown
	__end_of_initCountDown:
;; =============== function _initCountDown ends ============

	signat	_initCountDown,88
	global	_isr
psect	text264,local,class=CODE,delta=2
global __ptext264
__ptext264:

;; *************** function _isr *****************
;; Defined at:
;;		line 29 in file "C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
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
psect	text264
	file	"C:\Users\Matt\Dropbox\Progetto microcontrollers (Zappa)\spaceMission.c"
	line	29
	global	__size_of_isr
	__size_of_isr	equ	__end_of_isr-_isr
	
_isr:	
	opt	stack 5
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
psect	text264
	line	31
	
i1l1270:	
;spaceMission.c: 31: GIE=0;
	bcf	(95/8),(95)&7
	line	38
;spaceMission.c: 38: if (T0IF == 1){
	btfss	(90/8),(90)&7
	goto	u1_21
	goto	u1_20
u1_21:
	goto	i1l1290
u1_20:
	line	39
	
i1l1272:	
;spaceMission.c: 39: T0IF=0;
	bcf	(90/8),(90)&7
	line	40
	
i1l1274:	
;spaceMission.c: 40: if (divider==25){
	movf	(_divider),w
	xorlw	019h
	skipz
	goto	u2_21
	goto	u2_20
u2_21:
	goto	i1l1288
u2_20:
	line	41
	
i1l1276:	
;spaceMission.c: 41: divider=0;
	clrc
	movlw	0
	btfsc	status,0
	movlw	1
	movwf	(_divider)
	line	43
	
i1l1278:	
;spaceMission.c: 43: if(digit0 == 0){
	movf	((_digit0+1)),w
	iorwf	((_digit0)),w
	skipz
	goto	u3_21
	goto	u3_20
u3_21:
	goto	i1l1286
u3_20:
	line	44
	
i1l1280:	
;spaceMission.c: 44: if(digit1 == 0){
	movf	((_digit1+1)),w
	iorwf	((_digit1)),w
	skipz
	goto	u4_21
	goto	u4_20
u4_21:
	goto	i1l1284
u4_20:
	line	46
	
i1l1282:	
;spaceMission.c: 46: endGame = 1;
	movlw	low(01h)
	movwf	(_endGame)
	movlw	high(01h)
	movwf	((_endGame))+1
	line	47
;spaceMission.c: 47: }else{
	goto	i1l1290
	
i1l864:	
	line	49
	
i1l1284:	
;spaceMission.c: 49: digit1--;
	movlw	low(01h)
	subwf	(_digit1),f
	movlw	high(01h)
	skipc
	decf	(_digit1+1),f
	subwf	(_digit1+1),f
	line	50
;spaceMission.c: 50: digit0 = 9;
	movlw	low(09h)
	movwf	(_digit0)
	movlw	high(09h)
	movwf	((_digit0))+1
	goto	i1l1290
	line	51
	
i1l865:	
	line	52
;spaceMission.c: 51: }
;spaceMission.c: 52: }else
	goto	i1l1290
	
i1l863:	
	line	53
	
i1l1286:	
;spaceMission.c: 53: digit0--;
	movlw	low(01h)
	subwf	(_digit0),f
	movlw	high(01h)
	skipc
	decf	(_digit0+1),f
	subwf	(_digit0+1),f
	goto	i1l1290
	
i1l866:	
	line	54
;spaceMission.c: 54: }
	goto	i1l1290
	line	55
	
i1l862:	
	line	56
	
i1l1288:	
;spaceMission.c: 55: else
;spaceMission.c: 56: divider++;
	movlw	(01h)
	movwf	(??_isr+0)+0
	movf	(??_isr+0)+0,w
	addwf	(_divider),f
	goto	i1l1290
	
i1l867:	
	goto	i1l1290
	line	57
	
i1l861:	
	line	58
	
i1l1290:	
;spaceMission.c: 57: }
;spaceMission.c: 58: GIE=1;
	bsf	(95/8),(95)&7
	line	59
	
i1l868:	
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
psect	text265,local,class=CODE,delta=2
global __ptext265
__ptext265:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
