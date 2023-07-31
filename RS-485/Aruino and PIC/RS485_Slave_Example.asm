
_interrupt:

;RS485_Slave_Example.mbas,12 :: 		sub procedure interrupt()
;RS485_Slave_Example.mbas,13 :: 		RS485Slave_Receive(dat)
	MOVLW       _dat+0
	MOVWF       FARG_Rs485slave_Receive_data_buffer+0 
	MOVLW       hi_addr(_dat+0)
	MOVWF       FARG_Rs485slave_Receive_data_buffer+1 
	CALL        _Rs485slave_Receive+0, 0
;RS485_Slave_Example.mbas,14 :: 		if UART1_Data_Ready() then
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__interrupt2
;RS485_Slave_Example.mbas,15 :: 		receivedByte = UART1_Read()  ' Read the byte from UART1
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _receivedByte+0 
;RS485_Slave_Example.mbas,16 :: 		dataReceived = TRUE          ' Set the flag to indicate data is received
	MOVLW       255
	MOVWF       _dataReceived+0 
L__interrupt2:
;RS485_Slave_Example.mbas,18 :: 		end sub
L_end_interrupt:
L__interrupt20:
	RETFIE      1
; end of _interrupt

_main:

;RS485_Slave_Example.mbas,20 :: 		main:
;RS485_Slave_Example.mbas,21 :: 		UART1_Init(9600)                ' initialize UART1 module
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;RS485_Slave_Example.mbas,22 :: 		Delay_ms(100)
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L__main5:
	DECFSZ      R13, 1, 1
	BRA         L__main5
	DECFSZ      R12, 1, 1
	BRA         L__main5
	DECFSZ      R11, 1, 1
	BRA         L__main5
	NOP
;RS485_Slave_Example.mbas,23 :: 		RS485Slave_Init(160)           ' Initialize MCU as slave, address 160
	MOVLW       160
	MOVWF       FARG_Rs485slave_Init_slave_address+0 
	CALL        _Rs485slave_Init+0, 0
;RS485_Slave_Example.mbas,24 :: 		TRISB = 0x00                   ' Set PORTB as output
	CLRF        TRISB+0 
;RS485_Slave_Example.mbas,25 :: 		dataReceived = TRUE
	MOVLW       255
	MOVWF       _dataReceived+0 
;RS485_Slave_Example.mbas,26 :: 		receivedByte = 1
	MOVLW       1
	MOVWF       _receivedByte+0 
;RS485_Slave_Example.mbas,27 :: 		RCIE_bit = 1                   ' enable interrupt on UART1 receive
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;RS485_Slave_Example.mbas,28 :: 		TXIE_bit = 0                   ' disable interrupt on UART1 transmit
	BCF         TXIE_bit+0, BitPos(TXIE_bit+0) 
;RS485_Slave_Example.mbas,29 :: 		PEIE_bit = 1                   ' enable peripheral interrupts
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;RS485_Slave_Example.mbas,30 :: 		GIE_bit = 1                    ' enable all interrupts
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;RS485_Slave_Example.mbas,32 :: 		while (TRUE)
L__main7:
;RS485_Slave_Example.mbas,33 :: 		if(dataReceived) then
	MOVF        _dataReceived+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__main12
;RS485_Slave_Example.mbas,34 :: 		dataReceived = false   ' Reset the flag
	CLRF        _dataReceived+0 
;RS485_Slave_Example.mbas,36 :: 		if(receivedByte = 1) then
	MOVF        _receivedByte+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__main15
;RS485_Slave_Example.mbas,37 :: 		PORTB.0 = 1
	BSF         PORTB+0, 0 
;RS485_Slave_Example.mbas,38 :: 		Delay_ms(1000)
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L__main17:
	DECFSZ      R13, 1, 1
	BRA         L__main17
	DECFSZ      R12, 1, 1
	BRA         L__main17
	DECFSZ      R11, 1, 1
	BRA         L__main17
	NOP
	NOP
	GOTO        L__main16
;RS485_Slave_Example.mbas,39 :: 		else
L__main15:
;RS485_Slave_Example.mbas,40 :: 		PORTB.0 = 0
	BCF         PORTB+0, 0 
;RS485_Slave_Example.mbas,41 :: 		Delay_ms(1000)
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L__main18:
	DECFSZ      R13, 1, 1
	BRA         L__main18
	DECFSZ      R12, 1, 1
	BRA         L__main18
	DECFSZ      R11, 1, 1
	BRA         L__main18
	NOP
	NOP
;RS485_Slave_Example.mbas,42 :: 		end if
L__main16:
L__main12:
;RS485_Slave_Example.mbas,46 :: 		wend
	GOTO        L__main7
L_end_main:
	GOTO        $+0
; end of _main
