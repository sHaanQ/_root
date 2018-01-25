// Date and time functions using a DS1307 RTC connected via I2C and Wire lib
#include <Wire.h>
#include <RTClib.h>

// set shift register pins
#define data_pin 13
#define latch_pin 12
#define clock_pin 11

// set digit segments 5V pins
#define d1_pin 1
#define d2_pin 2
#define d3_pin 3
#define d4_pin 4
#define dot_pin 7
#define btn_pin 9

#define mux_delay 3 // set delay between switching display of digits

// define digits, 0 - on, 1 - off
byte segments[10] = {
  0b00000001, // 0
  0b01100111, // 1
  0b00010010, // 2
  0b01000010, // 3
  0b01100100, // 4
  0b01001000, // 5
  0b00001000, // 6
  0b01100011, // 7
  0b00000000, // 8
  0b01000000  // 9
};

byte segments_off = 0b01111111;

// create RTC object for clock
RTC_DS1307 RTC;


// HELPER FUNCTIONS

// clears digits on display by turning power off
void clearDisplay() {
  digitalWrite(d1_pin, LOW);
  digitalWrite(d2_pin, LOW);
  digitalWrite(d3_pin, LOW);
  digitalWrite(d4_pin, LOW);
}

// display single digit
void displayDigit(int digit_pin, int number) {
  // using shift register to light up required led segments
  digitalWrite(latch_pin, LOW);
  shiftOut(data_pin, clock_pin, LSBFIRST, segments[number]);
  digitalWrite(latch_pin, HIGH);
  // blank display
  clearDisplay();
  // light up required digit
  digitalWrite(digit_pin, HIGH); 
}

// display time
void displayTime(int hours, int minutes) {
  int h1, h2, m1, m2;
  h2 = hours % 10;
  h1 = ((hours % 100) - h1) / 10;
  m2 = minutes % 10;
  m1 = ((minutes % 100) - m1) / 10;
  
  if (h1==0) {
    clearDisplay(); // diplay first hour digit only if it is greater than 0
  }
  else
  {
    displayDigit(d1_pin, h1);
  }
  delay(mux_delay);
  displayDigit(d2_pin, h2);
  delay(mux_delay);
  displayDigit(d3_pin, m1);
  delay(mux_delay);
  displayDigit(d4_pin, m2);
  delay(mux_delay);
}

// blink dot
void blinkDot(int seconds) {
  if ( (seconds % 2) == 0 ) {
    clearDisplay();
    digitalWrite(latch_pin, LOW);
    shiftOut(data_pin, clock_pin, LSBFIRST, segments_off);
    digitalWrite(latch_pin, HIGH);
    digitalWrite(d2_pin, HIGH);    
    digitalWrite(dot_pin, LOW);
  } else {
    clearDisplay();
    digitalWrite(dot_pin, HIGH);
  }
  delay(mux_delay);
}

// display date
void displayDate(int days, int months) {
  int d1, d2, m1, m2;
  d2 = days % 10;
  d1 = ((days % 100) - d1) / 10;
  m2 = months % 10;
  m1 = ((months % 100) - m1) / 10;
  if (d1 == 0) {
    clearDisplay(); // diplay first hour digit only if it is greater than 0
  } else {
    displayDigit(d1_pin, d1);
  }
  delay(mux_delay);
  displayDigit(d2_pin, d2);
  digitalWrite(dot_pin, LOW);
  delay(mux_delay);
  digitalWrite(dot_pin, HIGH);
  displayDigit(d3_pin, m1);
  delay(mux_delay);
  displayDigit(d4_pin, m2);
  delay(mux_delay);
}


// MAIN PROGRAM BODY

void setup() {

  // set pin modes
  pinMode(data_pin, OUTPUT);
  pinMode(latch_pin, OUTPUT);
  pinMode(clock_pin, OUTPUT);
  pinMode(d1_pin, OUTPUT);
  pinMode(d2_pin, OUTPUT);
  pinMode(d3_pin, OUTPUT);
  pinMode(d4_pin, OUTPUT);
  pinMode(dot_pin, OUTPUT);
  pinMode(btn_pin, INPUT_PULLUP); // activate pullup resistor for button pin in atmega
  
  // start connection with clock and the clock itself
  Wire.begin();
  RTC.begin();
  
  // set the clock to current system time - uncomment when need to set time then comment again
  // RTC.adjust(DateTime(__DATE__, __TIME__));
}

void loop() {
  
  // read time
  DateTime now = RTC.now();
  int hours = now.hour();
  int minutes = now.minute();
  int seconds = now.second();
  int days = now.day();
  int months = now.month();
    
  // display date if button is pressed and time otherwise
  if ( digitalRead(btn_pin) == LOW) {
    displayDate(days, months);
  } else {
    displayTime(hours, minutes);
    blinkDot(seconds); // blink divider dot
  }
  
}
