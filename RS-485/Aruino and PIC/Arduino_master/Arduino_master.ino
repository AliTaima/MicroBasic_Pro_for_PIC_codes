const int DE_PIN = 4; // Arduino digital pin connected to RS485 module DE (Data Enable) or RE (Receiver Enable)

void setup() {
  Serial.begin(9600); // For debugging, connect the Arduino to your computer via USB
  pinMode(DE_PIN, OUTPUT);
  digitalWrite(DE_PIN, HIGH); // Set DE pin HIGH to enable transmission mode (send data)
}

void loop() {
  byte sendData = 1;  // Example data to send, modify as needed

  // Send data to the slave
  digitalWrite(DE_PIN, HIGH); // Set DE pin HIGH for transmission mode
  Serial.write(sendData);

  // Wait for the response from the slave
  delay(10); // Adjust this delay based on your slave's response time
  digitalWrite(DE_PIN, LOW); // Set DE pin LOW for reception mode

  // Process the received data (e.g., display or use it as needed)
  // This part is done on the Mikrobasic Pro side, so nothing to do here

  // Add some delay between consecutive requests to the slave
  delay(1000); // Adjust this delay based on your application requirements
}
