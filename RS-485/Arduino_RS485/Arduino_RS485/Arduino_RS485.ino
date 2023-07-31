/**
 *  Modbus slave example 2:
 *  The purpose of this example is to link the Arduino digital and analog
 *  pins to an external device.
 *
 *  Recommended Modbus Master: QModbus
 *  http://qmodbus.sourceforge.net/
 *
 *  Editado al español por LuxARTS
 */

//Incluye la librería del protocolo Modbus
#include <ModbusRtu.h>
#define ID   1 // slave id 

//Crear instancia
Modbus slave(ID, Serial, 0); //ID del nodo. 0 para el master, 1-247 para esclavo
                        //Puerto serie (0 = TX: 1 - RX: 0)
                        //Protocolo serie. 0 para RS-232 + USB (default), cualquier pin mayor a 1 para RS-485



uint16_t au16data[10]; //variabel au16data untuk pengitiman data modbus sebanyak 10 data
/*********************************************************
 Configuración del programa
*********************************************************/
void setup() {

Serial.begin(9600); //Abre la comunicación como esclavo


//DIGITAL OUTPUT
pinMode(2,OUTPUT);
//DIGITAL INPUT
pinMode(3,INPUT);
//ANALOG OUTPUT
pinMode(6,OUTPUT);
analogWrite(6,0);

slave.start();
}

/*********************************************************
 Inicio del programa
*********************************************************/
void loop() {
slave.poll( au16data,10);
// digital input
bitWrite(au16data[0], 0, digitalRead(3)); //digunakan untuk membaca nilai input pin 3 dan disimpan di au16data[0]
                                          //read holding register berada di 40001
//digital output
digitalWrite(2, bitRead(au16data[1],0));  //digunakan untuk membaca nilai au16data[1] dan mengirimkan nilai dari pembacaan ke pin  2
                                          //read holding register berada di 40002
//analog output pwm                                          
analogWrite(6, au16data[2]);              //digunakan untuk mengirimkan nilai analog pwm dari au16data[2] ke pin 6
                                          //read holding register berada di 40003
//analog input
au16data[3] = analogRead(A0);             //digunakan untuk membaca nilai input analog pin A0 dan disimpan au16data[2]
                                          //read holding register berada di 40003
                                          
} 
