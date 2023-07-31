
_main:

;LCD.mbas,21 :: 		main:
;LCD.mbas,23 :: 		Lcd_Init()                     ' Initialize Lcd
	CALL        _Lcd_Init+0, 0
;LCD.mbas,24 :: 		Lcd_Out(1,1,"Ali")              ' Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       65
	MOVWF       ?LocalText_main+0 
	MOVLW       108
	MOVWF       ?LocalText_main+1 
	MOVLW       105
	MOVWF       ?LocalText_main+2 
	CLRF        ?LocalText_main+3 
	MOVLW       ?LocalText_main+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?LocalText_main+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_end_main:
	GOTO        $+0
; end of _main
