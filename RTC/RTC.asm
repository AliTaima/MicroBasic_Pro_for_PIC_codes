
_msb:

;RTC.mbas,29 :: 		sub function msb(dim x as char) as char ' Yet another function. Make sure that parameters match the type definition
;RTC.mbas,30 :: 		result = (x>>4)+$30 '$30 to add '0' at the end to display it correctly
	MOVLW       4
	MOVWF       R1 
	MOVF        FARG_msb_x+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__msb15:
	BZ          L__msb16
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__msb15
L__msb16:
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       R2 
;RTC.mbas,31 :: 		end sub
	MOVF        R2, 0 
	MOVWF       R0 
L_end_msb:
	RETURN      0
; end of _msb

_lsb:

;RTC.mbas,33 :: 		sub function lsb(dim x as char) as char
;RTC.mbas,34 :: 		result = (x and 0x0f)+$30
	MOVLW       15
	ANDWF       FARG_lsb_x+0, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       R1 
;RTC.mbas,35 :: 		end sub
	MOVF        R1, 0 
	MOVWF       R0 
L_end_lsb:
	RETURN      0
; end of _lsb

_read_ds1307:

;RTC.mbas,36 :: 		sub function read_ds1307(dim adress as byte) as byte
;RTC.mbas,37 :: 		Soft_I2C_Start()              ' Issue start signal
	CALL        _Soft_I2C_Start+0, 0
;RTC.mbas,38 :: 		Soft_I2C_Write(0xd0)          ' Address ds1307
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;RTC.mbas,39 :: 		Soft_I2C_Write(adress)             ' Start from address 2
	MOVF        FARG_read_ds1307_adress+0, 0 
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;RTC.mbas,40 :: 		Soft_I2C_Start()              ' Issue repeated start signal
	CALL        _Soft_I2C_Start+0, 0
;RTC.mbas,41 :: 		Soft_I2C_Write(0xd1)          ' Address PCF8583 for reading R/W=1
	MOVLW       209
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;RTC.mbas,42 :: 		result = Soft_I2C_Read(0)
	CLRF        FARG_Soft_I2C_Read_ack+0 
	CLRF        FARG_Soft_I2C_Read_ack+1 
	CALL        _Soft_I2C_Read+0, 0
	MOVF        R0, 0 
	MOVWF       read_ds1307_local_result+0 
;RTC.mbas,43 :: 		Soft_I2C_Stop()               ' Issue stop signal}
	CALL        _Soft_I2C_Stop+0, 0
;RTC.mbas,44 :: 		end sub
	MOVF        read_ds1307_local_result+0, 0 
	MOVWF       R0 
L_end_read_ds1307:
	RETURN      0
; end of _read_ds1307

_Read_Time:

;RTC.mbas,47 :: 		sub procedure Read_Time()
;RTC.mbas,48 :: 		seconds = read_ds1307(0)        'read second byte
	CLRF        FARG_read_ds1307_adress+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _seconds+0 
;RTC.mbas,49 :: 		minutes = read_ds1307(1)        'read minute byte
	MOVLW       1
	MOVWF       FARG_read_ds1307_adress+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _minutes+0 
;RTC.mbas,50 :: 		hours = read_ds1307(2)          'read hour byte
	MOVLW       2
	MOVWF       FARG_read_ds1307_adress+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _hours+0 
;RTC.mbas,51 :: 		day = read_ds1307(4)            'read day byte
	MOVLW       4
	MOVWF       FARG_read_ds1307_adress+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _day+0 
;RTC.mbas,52 :: 		month = read_ds1307(5)          'read month byte
	MOVLW       5
	MOVWF       FARG_read_ds1307_adress+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _month+0 
;RTC.mbas,53 :: 		year = read_ds1307(6)           'read year byte
	MOVLW       6
	MOVWF       FARG_read_ds1307_adress+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _year+0 
;RTC.mbas,54 :: 		time[0] = msb(hours)
	MOVF        _hours+0, 0 
	MOVWF       FARG_msb_x+0 
	CALL        _msb+0, 0
	MOVF        R0, 0 
	MOVWF       _time+0 
;RTC.mbas,55 :: 		time[1] = lsb(hours)
	MOVF        _hours+0, 0 
	MOVWF       FARG_lsb_x+0 
	CALL        _lsb+0, 0
	MOVF        R0, 0 
	MOVWF       _time+1 
;RTC.mbas,56 :: 		time[3] = msb(minutes)
	MOVF        _minutes+0, 0 
	MOVWF       FARG_msb_x+0 
	CALL        _msb+0, 0
	MOVF        R0, 0 
	MOVWF       _time+3 
;RTC.mbas,57 :: 		time[4] = lsb(minutes)
	MOVF        _minutes+0, 0 
	MOVWF       FARG_lsb_x+0 
	CALL        _lsb+0, 0
	MOVF        R0, 0 
	MOVWF       _time+4 
;RTC.mbas,58 :: 		time[6] = msb(seconds)
	MOVF        _seconds+0, 0 
	MOVWF       FARG_msb_x+0 
	CALL        _msb+0, 0
	MOVF        R0, 0 
	MOVWF       _time+6 
;RTC.mbas,59 :: 		time[7] = lsb(seconds)
	MOVF        _seconds+0, 0 
	MOVWF       FARG_lsb_x+0 
	CALL        _lsb+0, 0
	MOVF        R0, 0 
	MOVWF       _time+7 
;RTC.mbas,60 :: 		date[0] = msb(day)
	MOVF        _day+0, 0 
	MOVWF       FARG_msb_x+0 
	CALL        _msb+0, 0
	MOVF        R0, 0 
	MOVWF       _date+0 
;RTC.mbas,61 :: 		date[1] = lsb(day)
	MOVF        _day+0, 0 
	MOVWF       FARG_lsb_x+0 
	CALL        _lsb+0, 0
	MOVF        R0, 0 
	MOVWF       _date+1 
;RTC.mbas,62 :: 		date[3] = msb(month)
	MOVF        _month+0, 0 
	MOVWF       FARG_msb_x+0 
	CALL        _msb+0, 0
	MOVF        R0, 0 
	MOVWF       _date+3 
;RTC.mbas,63 :: 		date[4] = lsb(month)
	MOVF        _month+0, 0 
	MOVWF       FARG_lsb_x+0 
	CALL        _lsb+0, 0
	MOVF        R0, 0 
	MOVWF       _date+4 
;RTC.mbas,64 :: 		date[6] = msb(year)
	MOVF        _year+0, 0 
	MOVWF       FARG_msb_x+0 
	CALL        _msb+0, 0
	MOVF        R0, 0 
	MOVWF       _date+6 
;RTC.mbas,65 :: 		date[7] = lsb(year)
	MOVF        _year+0, 0 
	MOVWF       FARG_lsb_x+0 
	CALL        _lsb+0, 0
	MOVF        R0, 0 
	MOVWF       _date+7 
;RTC.mbas,67 :: 		end sub
L_end_Read_Time:
	RETURN      0
; end of _Read_Time

_Display_Time:

;RTC.mbas,72 :: 		sub procedure Display_Time()
;RTC.mbas,73 :: 		lcd_out(2, 6, time)
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _time+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_time+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;RTC.mbas,74 :: 		lcd_out(1, 6, date)
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _date+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_date+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;RTC.mbas,75 :: 		end sub
L_end_Display_Time:
	RETURN      0
; end of _Display_Time

_Init_Main:

;RTC.mbas,78 :: 		sub procedure Init_Main()
;RTC.mbas,79 :: 		time = "00:00:00"
	MOVLW       48
	MOVWF       _time+0 
	MOVLW       48
	MOVWF       _time+1 
	MOVLW       58
	MOVWF       _time+2 
	MOVLW       48
	MOVWF       _time+3 
	MOVLW       48
	MOVWF       _time+4 
	MOVLW       58
	MOVWF       _time+5 
	MOVLW       48
	MOVWF       _time+6 
	MOVLW       48
	MOVWF       _time+7 
	CLRF        _time+8 
;RTC.mbas,80 :: 		date = "00/00/00"
	MOVLW       48
	MOVWF       _date+0 
	MOVLW       48
	MOVWF       _date+1 
	MOVLW       47
	MOVWF       _date+2 
	MOVLW       48
	MOVWF       _date+3 
	MOVLW       48
	MOVWF       _date+4 
	MOVLW       47
	MOVWF       _date+5 
	MOVLW       48
	MOVWF       _date+6 
	MOVLW       48
	MOVWF       _date+7 
	CLRF        _date+8 
;RTC.mbas,81 :: 		TRISB = 0
	CLRF        TRISB+0 
;RTC.mbas,82 :: 		PORTB = 0xFF
	MOVLW       255
	MOVWF       PORTB+0 
;RTC.mbas,83 :: 		TRISB = 0xFF
	MOVLW       255
	MOVWF       TRISB+0 
;RTC.mbas,84 :: 		ADCON1 = 0xFF
	MOVLW       255
	MOVWF       ADCON1+0 
;RTC.mbas,86 :: 		CMCON = 0xFF
	MOVLW       255
	MOVWF       CMCON+0 
;RTC.mbas,87 :: 		Soft_I2C_Init()           ' Initialize Soft I2C communication
	CALL        _Soft_I2C_Init+0, 0
;RTC.mbas,89 :: 		Lcd_Init()                ' Initialize Lcd
	CALL        _Lcd_Init+0, 0
;RTC.mbas,90 :: 		Lcd_Cmd(_LCD_CLEAR)       ' Clear Lcd display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RTC.mbas,91 :: 		Lcd_Cmd(_LCD_CURSOR_OFF)  ' Turn cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RTC.mbas,93 :: 		Lcd_Out(1,1,"Date:")      ' Prepare and output static text on Lcd
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
;RTC.mbas,95 :: 		Lcd_Out(2,1,"Time:")
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
;RTC.mbas,97 :: 		end sub
L_end_Init_Main:
	RETURN      0
; end of _Init_Main

_main:

;RTC.mbas,100 :: 		main:
;RTC.mbas,101 :: 		Delay_ms(500)
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L__main7:
	DECFSZ      R13, 1, 1
	BRA         L__main7
	DECFSZ      R12, 1, 1
	BRA         L__main7
	DECFSZ      R11, 1, 1
	BRA         L__main7
	NOP
	NOP
;RTC.mbas,103 :: 		Init_Main()             ' Perform initialization
	CALL        _Init_Main+0, 0
;RTC.mbas,105 :: 		while TRUE              ' Endless loop
L__main9:
;RTC.mbas,106 :: 		Read_Time()           ' Read time from RTC(PCF8583)
	CALL        _Read_Time+0, 0
;RTC.mbas,107 :: 		Display_Time()      ' Format date and time
	CALL        _Display_Time+0, 0
;RTC.mbas,108 :: 		Delay_ms(100)
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L__main13:
	DECFSZ      R13, 1, 1
	BRA         L__main13
	DECFSZ      R12, 1, 1
	BRA         L__main13
	DECFSZ      R11, 1, 1
	BRA         L__main13
	NOP
;RTC.mbas,109 :: 		wend
	GOTO        L__main9
L_end_main:
	GOTO        $+0
; end of _main
