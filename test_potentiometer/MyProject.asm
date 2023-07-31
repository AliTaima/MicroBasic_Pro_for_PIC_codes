
_main:

;MyProject.mbas,7 :: 		main:
;MyProject.mbas,8 :: 		UART1_Init(9600)                     ' Initialize UART module at 9600 bps
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;MyProject.mbas,9 :: 		Delay_ms(100)                        ' Wait for UART module to stabilize
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L__main1:
	DECFSZ      R13, 1, 1
	BRA         L__main1
	DECFSZ      R12, 1, 1
	BRA         L__main1
	DECFSZ      R11, 1, 1
	BRA         L__main1
	NOP
;MyProject.mbas,10 :: 		UART1_Write_Text("Readyyy")
	MOVLW       82
	MOVWF       ?LocalText_main+0 
	MOVLW       101
	MOVWF       ?LocalText_main+1 
	MOVLW       97
	MOVWF       ?LocalText_main+2 
	MOVLW       100
	MOVWF       ?LocalText_main+3 
	MOVLW       121
	MOVWF       ?LocalText_main+4 
	MOVLW       121
	MOVWF       ?LocalText_main+5 
	MOVLW       121
	MOVWF       ?LocalText_main+6 
	CLRF        ?LocalText_main+7 
	MOVLW       ?LocalText_main+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?LocalText_main+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.mbas,11 :: 		ADC_Init()
	CALL        _ADC_Init+0, 0
;MyProject.mbas,12 :: 		CMCON = CMCON or 0x07 ' turn off comparators
	MOVLW       7
	IORWF       CMCON+0, 1 
;MyProject.mbas,13 :: 		ADCON1 = ADCON1 or 0x0C ' Set AN2 channel pin as analog
	MOVLW       12
	IORWF       ADCON1+0, 1 
;MyProject.mbas,14 :: 		TRISA2_bit = 1 ' input
	BSF         TRISA2_bit+0, BitPos(TRISA2_bit+0) 
;MyProject.mbas,15 :: 		TRISB = 0x00 ' Set PORTB as output
	CLRF        TRISB+0 
;MyProject.mbas,16 :: 		TRISC = 0x00 ' Set PORTC as output
	CLRF        TRISC+0 
;MyProject.mbas,17 :: 		while (TRUE)
L__main3:
;MyProject.mbas,18 :: 		adc_rd = ADC_Read(2) ' get ADC value from 2nd channel
	MOVLW       2
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _adc_rd+0 
	MOVF        R1, 0 
	MOVWF       _adc_rd+1 
;MyProject.mbas,19 :: 		WordToStr(adc_rd, str)
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _str+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;MyProject.mbas,20 :: 		UART1_Write_Text(str)             ' and send data via UART
	MOVLW       _str+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.mbas,21 :: 		PORTB.1 = 0
	BCF         PORTB+0, 1 
;MyProject.mbas,22 :: 		PORTB.2 = 1
	BSF         PORTB+0, 2 
;MyProject.mbas,23 :: 		Delay_ms(100)
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L__main7:
	DECFSZ      R13, 1, 1
	BRA         L__main7
	DECFSZ      R12, 1, 1
	BRA         L__main7
	DECFSZ      R11, 1, 1
	BRA         L__main7
	NOP
;MyProject.mbas,24 :: 		PORTB.1 = 1
	BSF         PORTB+0, 1 
;MyProject.mbas,25 :: 		PORTB.2 = 0
	BCF         PORTB+0, 2 
;MyProject.mbas,26 :: 		Delay_ms(1000)
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L__main8:
	DECFSZ      R13, 1, 1
	BRA         L__main8
	DECFSZ      R12, 1, 1
	BRA         L__main8
	DECFSZ      R11, 1, 1
	BRA         L__main8
	NOP
	NOP
;MyProject.mbas,27 :: 		wend
	GOTO        L__main3
L_end_main:
	GOTO        $+0
; end of _main
