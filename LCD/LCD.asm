
_main:

;LCD.mbas,24 :: 		main:
;LCD.mbas,27 :: 		TRISB = 0
	CLRF        TRISB+0 
;LCD.mbas,28 :: 		PORTB = 0xFF
	MOVLW       255
	MOVWF       PORTB+0 
;LCD.mbas,29 :: 		TRISB = 0xFF
	MOVLW       255
	MOVWF       TRISB+0 
;LCD.mbas,30 :: 		ADCON1  = 0xFF                     ' Configure AN pins as digital I/O  ***most important***
	MOVLW       255
	MOVWF       ADCON1+0 
;LCD.mbas,32 :: 		txt1 = "mikroElektronika"
	MOVLW       109
	MOVWF       _txt1+0 
	MOVLW       105
	MOVWF       _txt1+1 
	MOVLW       107
	MOVWF       _txt1+2 
	MOVLW       114
	MOVWF       _txt1+3 
	MOVLW       111
	MOVWF       _txt1+4 
	MOVLW       69
	MOVWF       _txt1+5 
	MOVLW       108
	MOVWF       _txt1+6 
	MOVLW       101
	MOVWF       _txt1+7 
	MOVLW       107
	MOVWF       _txt1+8 
	MOVLW       116
	MOVWF       _txt1+9 
	MOVLW       114
	MOVWF       _txt1+10 
	MOVLW       111
	MOVWF       _txt1+11 
	MOVLW       110
	MOVWF       _txt1+12 
	MOVLW       105
	MOVWF       _txt1+13 
	MOVLW       107
	MOVWF       _txt1+14 
	MOVLW       97
	MOVWF       _txt1+15 
	CLRF        _txt1+16 
;LCD.mbas,33 :: 		txt2 = "EasyPIC6"
	MOVLW       69
	MOVWF       _txt2+0 
	MOVLW       97
	MOVWF       _txt2+1 
	MOVLW       115
	MOVWF       _txt2+2 
	MOVLW       121
	MOVWF       _txt2+3 
	MOVLW       80
	MOVWF       _txt2+4 
	MOVLW       73
	MOVWF       _txt2+5 
	MOVLW       67
	MOVWF       _txt2+6 
	MOVLW       54
	MOVWF       _txt2+7 
	CLRF        _txt2+8 
;LCD.mbas,34 :: 		txt3 = "Lcd4bit"
	MOVLW       76
	MOVWF       _txt3+0 
	MOVLW       99
	MOVWF       _txt3+1 
	MOVLW       100
	MOVWF       _txt3+2 
	MOVLW       52
	MOVWF       _txt3+3 
	MOVLW       98
	MOVWF       _txt3+4 
	MOVLW       105
	MOVWF       _txt3+5 
	MOVLW       116
	MOVWF       _txt3+6 
	CLRF        _txt3+7 
;LCD.mbas,35 :: 		txt4 = "example"
	MOVLW       101
	MOVWF       _txt4+0 
	MOVLW       120
	MOVWF       _txt4+1 
	MOVLW       97
	MOVWF       _txt4+2 
	MOVLW       109
	MOVWF       _txt4+3 
	MOVLW       112
	MOVWF       _txt4+4 
	MOVLW       108
	MOVWF       _txt4+5 
	MOVLW       101
	MOVWF       _txt4+6 
	CLRF        _txt4+7 
;LCD.mbas,37 :: 		Lcd_Init()                     ' Initialize Lcd
	CALL        _Lcd_Init+0, 0
;LCD.mbas,38 :: 		Lcd_Cmd(_LCD_CLEAR)            ' Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCD.mbas,39 :: 		Lcd_Cmd(_LCD_CURSOR_OFF)       ' Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCD.mbas,40 :: 		Lcd_Out(1,6,txt3)              ' Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt3+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt3+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCD.mbas,41 :: 		Lcd_Out(2,6,txt4)              ' Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt4+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCD.mbas,42 :: 		Delay_ms(2000)
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L__main1:
	DECFSZ      R13, 1, 1
	BRA         L__main1
	DECFSZ      R12, 1, 1
	BRA         L__main1
	DECFSZ      R11, 1, 1
	BRA         L__main1
	NOP
;LCD.mbas,43 :: 		Lcd_Cmd(_LCD_CLEAR)            ' Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCD.mbas,45 :: 		Lcd_Out(1,1,txt1)              ' Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCD.mbas,46 :: 		Lcd_Out(2,5,txt2)              ' Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_end_main:
	GOTO        $+0
; end of _main
