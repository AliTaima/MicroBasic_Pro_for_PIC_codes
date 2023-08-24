
_Read_Time:

;RTC.mbas,27 :: 		sub procedure Read_Time()
;RTC.mbas,28 :: 		Soft_I2C_Start()              ' Issue start signal
	CALL        _Soft_I2C_Start+0, 0
;RTC.mbas,29 :: 		Soft_I2C_Write(0xd0)          ' Address PCF8583, see PCF8583 datasheet
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;RTC.mbas,30 :: 		Soft_I2C_Write(2)             ' Start from address 2
	MOVLW       2
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;RTC.mbas,31 :: 		Soft_I2C_Start()              ' Issue repeated start signal
	CALL        _Soft_I2C_Start+0, 0
;RTC.mbas,32 :: 		Soft_I2C_Write(0xd1)          ' Address PCF8583 for reading R/W=1
	MOVLW       209
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;RTC.mbas,33 :: 		seconds = Soft_I2C_Read(1)    ' Read seconds byte
	MOVLW       1
	MOVWF       FARG_Soft_I2C_Read_ack+0 
	MOVLW       0
	MOVWF       FARG_Soft_I2C_Read_ack+1 
	CALL        _Soft_I2C_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _seconds+0 
;RTC.mbas,34 :: 		minutes = Soft_I2C_Read(1)    ' Read minutes byte
	MOVLW       1
	MOVWF       FARG_Soft_I2C_Read_ack+0 
	MOVLW       0
	MOVWF       FARG_Soft_I2C_Read_ack+1 
	CALL        _Soft_I2C_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _minutes+0 
;RTC.mbas,35 :: 		hours = Soft_I2C_Read(1)      ' Read hours byte
	MOVLW       1
	MOVWF       FARG_Soft_I2C_Read_ack+0 
	MOVLW       0
	MOVWF       FARG_Soft_I2C_Read_ack+1 
	CALL        _Soft_I2C_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _hours+0 
;RTC.mbas,36 :: 		_day = Soft_I2C_Read(1)       ' Read year/day byte
	MOVLW       1
	MOVWF       FARG_Soft_I2C_Read_ack+0 
	MOVLW       0
	MOVWF       FARG_Soft_I2C_Read_ack+1 
	CALL        _Soft_I2C_Read+0, 0
	MOVF        R0, 0 
	MOVWF       __day+0 
;RTC.mbas,37 :: 		_month = Soft_I2C_Read(0)     ' Read weekday/month byte}
	CLRF        FARG_Soft_I2C_Read_ack+0 
	CLRF        FARG_Soft_I2C_Read_ack+1 
	CALL        _Soft_I2C_Read+0, 0
	MOVF        R0, 0 
	MOVWF       __month+0 
;RTC.mbas,38 :: 		Soft_I2C_Stop()               ' Issue stop signal}
	CALL        _Soft_I2C_Stop+0, 0
;RTC.mbas,39 :: 		end sub
L_end_Read_Time:
	RETURN      0
; end of _Read_Time

_Transform_Time:

;RTC.mbas,42 :: 		sub procedure Transform_Time()
;RTC.mbas,43 :: 		seconds  =  ((seconds and 0xF0) >> 4)*10 + (seconds and 0x0F)  ' Transform seconds
	MOVLW       240
	ANDWF       _seconds+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       _seconds+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       _seconds+0 
;RTC.mbas,44 :: 		minutes  =  ((minutes and 0xF0) >> 4)*10 + (minutes and 0x0F)  ' Transform months
	MOVLW       240
	ANDWF       _minutes+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       _minutes+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       _minutes+0 
;RTC.mbas,45 :: 		hours    =  ((hours and 0xF0)  >> 4)*10  + (hours and 0x0F)    ' Transform hours
	MOVLW       240
	ANDWF       _hours+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       _hours+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       _hours+0 
;RTC.mbas,46 :: 		year     =   (_day and 0xC0) >> 6                              ' Transform year
	MOVLW       192
	ANDWF       __day+0, 0 
	MOVWF       _year+0 
	MOVLW       6
	MOVWF       R0 
	MOVF        R0, 0 
L__Transform_Time13:
	BZ          L__Transform_Time14
	RRCF        _year+0, 1 
	BCF         _year+0, 7 
	ADDLW       255
	GOTO        L__Transform_Time13
L__Transform_Time14:
;RTC.mbas,47 :: 		_day      =  ((_day and 0x30) >> 4)*10    + (_day and 0x0F)    ' Transform day
	MOVLW       48
	ANDWF       __day+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       __day+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       __day+0 
;RTC.mbas,48 :: 		_month    =  ((_month and 0x10)  >> 4)*10 + (_month and 0x0F)  ' Transform month
	MOVLW       16
	ANDWF       __month+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       __month+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       __month+0 
;RTC.mbas,49 :: 		end sub
L_end_Transform_Time:
	RETURN      0
; end of _Transform_Time

_Display_Time:

;RTC.mbas,52 :: 		sub procedure Display_Time()
;RTC.mbas,53 :: 		Lcd_Chr(1, 6, (_day / 10)   + 48)    ' Print tens digit of day variable
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        __day+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,54 :: 		Lcd_Chr(1, 7, (_day mod 10)   + 48)  ' Print oness digit of day variable
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        __day+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,55 :: 		Lcd_Chr(1, 9, (_month / 10) + 48)    ' Print tens digit of month variable
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        __month+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,56 :: 		Lcd_Chr(1,10, (_month mod 10) + 48)  ' Print oness digit of month variable
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        __month+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,57 :: 		Lcd_Chr(1, 15, year        + 48)     ' Print year vaiable + 8 (start from year 2008)
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       48
	ADDWF       _year+0, 0 
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,59 :: 		Lcd_Chr(2, 6, (hours / 10)   + 48)   ' Print tens digit of hours variable
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _hours+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,60 :: 		Lcd_Chr(2, 7, (hours mod 10)   + 48) ' Print oness digit of hours variable
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _hours+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,61 :: 		Lcd_Chr(2, 9, (minutes / 10) + 48)   ' Print tens digit of minutes variable
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _minutes+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,62 :: 		Lcd_Chr(2,10, (minutes mod 10) + 48) ' Print oness digit of minutes variable
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _minutes+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,63 :: 		Lcd_Chr(2,12, (seconds / 10) + 48)   ' Print tens digit of seconds variable
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _seconds+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,64 :: 		Lcd_Chr(2,13, (seconds mod 10) + 48) ' Print oness digit of seconds variable
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       13
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _seconds+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,65 :: 		end sub
L_end_Display_Time:
	RETURN      0
; end of _Display_Time

_Init_Main:

;RTC.mbas,68 :: 		sub procedure Init_Main()
;RTC.mbas,70 :: 		TRISB = 0
	CLRF        TRISB+0 
;RTC.mbas,71 :: 		PORTB = 0xFF
	MOVLW       255
	MOVWF       PORTB+0 
;RTC.mbas,72 :: 		TRISB = 0xFF
	MOVLW       255
	MOVWF       TRISB+0 
;RTC.mbas,73 :: 		ADCON1 = 0xFF
	MOVLW       255
	MOVWF       ADCON1+0 
;RTC.mbas,75 :: 		CMCON = 0xFF
	MOVLW       255
	MOVWF       CMCON+0 
;RTC.mbas,76 :: 		Soft_I2C_Init()           ' Initialize Soft I2C communication
	CALL        _Soft_I2C_Init+0, 0
;RTC.mbas,78 :: 		Lcd_Init()                ' Initialize Lcd
	CALL        _Lcd_Init+0, 0
;RTC.mbas,79 :: 		Lcd_Cmd(_LCD_CLEAR)       ' Clear Lcd display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RTC.mbas,80 :: 		Lcd_Cmd(_LCD_CURSOR_OFF)  ' Turn cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RTC.mbas,82 :: 		Lcd_Out(1,1,"Date:")      ' Prepare and output static text on Lcd
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       68
	MOVWF       ?LocalText_Init_Main+0 
	MOVLW       97
	MOVWF       ?LocalText_Init_Main+1 
	MOVLW       116
	MOVWF       ?LocalText_Init_Main+2 
	MOVLW       101
	MOVWF       ?LocalText_Init_Main+3 
	MOVLW       58
	MOVWF       ?LocalText_Init_Main+4 
	CLRF        ?LocalText_Init_Main+5 
	MOVLW       ?LocalText_Init_Main+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?LocalText_Init_Main+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;RTC.mbas,83 :: 		Lcd_Chr(1,8,".")
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,84 :: 		Lcd_Chr(1,11,".")
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,85 :: 		Lcd_Chr(1,16,".")
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,86 :: 		Lcd_Out(2,1,"Time:")
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       84
	MOVWF       ?LocalText_Init_Main+0 
	MOVLW       105
	MOVWF       ?LocalText_Init_Main+1 
	MOVLW       109
	MOVWF       ?LocalText_Init_Main+2 
	MOVLW       101
	MOVWF       ?LocalText_Init_Main+3 
	MOVLW       58
	MOVWF       ?LocalText_Init_Main+4 
	CLRF        ?LocalText_Init_Main+5 
	MOVLW       ?LocalText_Init_Main+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?LocalText_Init_Main+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;RTC.mbas,87 :: 		Lcd_Chr(2,8,":")
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,88 :: 		Lcd_Chr(2,11,":")
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_Row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Chr_Column+0 
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_Out_Char+0 
	CALL        _Lcd_Chr+0, 0
;RTC.mbas,89 :: 		Lcd_Out(1,12,"201")       ' start from year 2010
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       50
	MOVWF       ?LocalText_Init_Main+0 
	MOVLW       48
	MOVWF       ?LocalText_Init_Main+1 
	MOVLW       49
	MOVWF       ?LocalText_Init_Main+2 
	CLRF        ?LocalText_Init_Main+3 
	MOVLW       ?LocalText_Init_Main+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?LocalText_Init_Main+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;RTC.mbas,90 :: 		end sub
L_end_Init_Main:
	RETURN      0
; end of _Init_Main

_main:

;RTC.mbas,96 :: 		main:
;RTC.mbas,97 :: 		Delay_ms(500)
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L__main5:
	DECFSZ      R13, 1, 1
	BRA         L__main5
	DECFSZ      R12, 1, 1
	BRA         L__main5
	DECFSZ      R11, 1, 1
	BRA         L__main5
	NOP
	NOP
;RTC.mbas,99 :: 		Init_Main()             ' Perform initialization
	CALL        _Init_Main+0, 0
;RTC.mbas,122 :: 		while TRUE              ' Endless loop
L__main7:
;RTC.mbas,123 :: 		Read_Time()           ' Read time from RTC(PCF8583)
	CALL        _Read_Time+0, 0
;RTC.mbas,124 :: 		Transform_Time()      ' Format date and time
	CALL        _Transform_Time+0, 0
;RTC.mbas,125 :: 		Display_Time()        ' Prepare and display on Lcd
	CALL        _Display_Time+0, 0
;RTC.mbas,126 :: 		wend
	GOTO        L__main7
L_end_main:
	GOTO        $+0
; end of _main
