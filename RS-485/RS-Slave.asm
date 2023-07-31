
_interrupt:

;RS-Slave.mbas,12 :: 		sub procedure interrupt()
;RS-Slave.mbas,13 :: 		RS485Slave_Receive(dat)
	MOVLW       _dat+0
	MOVWF       FARG_Rs485slave_Receive_data_buffer+0 
	MOVLW       hi_addr(_dat+0)
	MOVWF       FARG_Rs485slave_Receive_data_buffer+1 
	CALL        _Rs485slave_Receive+0, 0
;RS-Slave.mbas,14 :: 		end sub
L_end_interrupt:
L__interrupt9:
	RETFIE      1
; end of _interrupt

_main:

;RS-Slave.mbas,18 :: 		main:
;RS-Slave.mbas,20 :: 		UART1_Init(9600)              ' initialize UART1 module
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;RS-Slave.mbas,21 :: 		Delay_ms(100)
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L__main2:
	DECFSZ      R13, 1, 1
	BRA         L__main2
	DECFSZ      R12, 1, 1
	BRA         L__main2
	DECFSZ      R11, 1, 1
	BRA         L__main2
	NOP
;RS-Slave.mbas,22 :: 		RS485Slave_Init(160)          ' Initialize MCU as slave, address 160
	MOVLW       160
	MOVWF       FARG_Rs485slave_Init_slave_address+0 
	CALL        _Rs485slave_Init+0, 0
;RS-Slave.mbas,24 :: 		ADC_Init()                    ' Initialize ADC
	CALL        _ADC_Init+0, 0
;RS-Slave.mbas,25 :: 		TRISA2_bit = 1                ' Make pin A2 as input
	BSF         TRISA2_bit+0, BitPos(TRISA2_bit+0) 
;RS-Slave.mbas,27 :: 		RCIE_bit = 1                  ' enable interrupt on UART1 receive
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;RS-Slave.mbas,28 :: 		TXIE_bit = 0                  ' disable interrupt on UART1 transmit
	BCF         TXIE_bit+0, BitPos(TXIE_bit+0) 
;RS-Slave.mbas,29 :: 		PEIE_bit = 1                  ' enable peripheral interrupts
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;RS-Slave.mbas,30 :: 		GIE_bit = 1                   ' enable all interrupts
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;RS-Slave.mbas,32 :: 		dat[0] = 0                    ' Make sure that initial value of dat[0] is zero
	CLRF        _dat+0 
;RS-Slave.mbas,34 :: 		while TRUE
L__main4:
;RS-Slave.mbas,35 :: 		dat[0] = ADC_Read(2)     ' get ADC value from 2nd channel
	MOVLW       2
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dat+0 
;RS-Slave.mbas,36 :: 		RS485Slave_Send(dat,1)   '   and send it back to master
	MOVLW       _dat+0
	MOVWF       FARG_Rs485slave_Send_data_buffer+0 
	MOVLW       hi_addr(_dat+0)
	MOVWF       FARG_Rs485slave_Send_data_buffer+1 
	MOVLW       1
	MOVWF       FARG_Rs485slave_Send_datalen+0 
	CALL        _Rs485slave_Send+0, 0
;RS-Slave.mbas,38 :: 		wend
	GOTO        L__main4
L_end_main:
	GOTO        $+0
; end of _main
