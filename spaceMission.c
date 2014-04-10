#include <pic.h>
__CONFIG(0x23E2);

// Using 8Mhz, we use 25 as an approximate divider
#define DIVIDER 25

#define EMPTY 0x20
#define ASTEROIDS 0x23


// 7-digit leds encoding
const unsigned char map[]={63,6,91,79,102,109,125,7,127,111};

#define ENDGAME 0x1
#define COLLISION 0x2
#define POSITION 0x4

// --- Global variables ---
unsigned char status = 0; 
//unsigned char endGame = 0;		// 1 if game is finished
//unsigned char collision = 0;	// 1 if a collision happened
unsigned char divider=0;			// helper variable for 
unsigned char digit0=0;				// first digit of the countdown
unsigned char digit1=0;				// second digit of the countdown

char line0[16];            //Display Line 0
char line1[16];            //Display Line 1

unsigned char pointerLine;  //We can actually use two direct memory pointer to be faster



// --- Functions headers ---
void endMission();
void updateCountDown();
void sleep();
void initCountDown();
void updatePoints();
void updateSpace();	
void updateAsteroidsSpeed();


// --- Interrupts handling ---
void interrupt isr(void) {
    //disable all interrupts
	GIE=0;
	
	// TODO: Button up pressed: push up the spacecraft

	// TODO: Button down: pull down the spacecraft
	
	// Timer interrupt: decrement the count down
	if (T0IF == 1){
        T0IF=0;		//reset timer interrupt
        if (divider==DIVIDER){
            divider=0;
			
			if(digit0 == 0){
				if(digit1 == 0){
					// Both are zero: game finished
					endGame = 1;
				}else{
					// Carry from digit 1
					digit1--;
					digit0 = 9;
				}
			}else
				digit0--;	// Decrement digit 0
        }
        else
            divider++;
    }
    GIE=1; //enable all interrupt
}


// --- Main ---
int main(){
    // port settings
    ANSEL=0x00;
    ANSELH=0x00;

	TRISD=0b00000000;	// PORTD used for 7-digits leds 

    initCountDown();
	
	GIE=1;		//enable all interrupts

	// --- main loop ---
	while(1){
		// Countdown reached 0 
		// or the spacecraft collided with an asteroid
		if(endGame == 0 || collision == 1){
			endMission();			// End mission
		}else{
			updateCountDown();		// Update countdown
			updatePoints();			// Update points			
			updateSpace();			// Update asteroids and show them on LCD display
			updateAsteroidsSpeed();	// Poll ADC: set asteroids speed		
		}
	}
}

// TODO: This function is used to update the asteroids speed
void updateAsteroidsSpeed(){
	// Poll the value from the potentiometer, using the ADC
	
	// Normalize that value and store it in a global variable
}

// TODO: This function is used to update the asteroids and LCD display
void updateSpace(){
	// ASSUMPTION: Use 2 "circular" buffers (one for each line) of 16 digits each (line1 and line0)	
	// ASSUMPTION: Use a binary value to store the position of the spacecraft (up or down)

	// If line1[15] contains an asteroids, points++;
	// If line0[15] contains an asteroids, points++;
	// Left bit-shift both
	
	// if spacecraft is up and line1[15] == asteroids, collision = 1
	// else
	// if spacecraft is up and line0[15] == asteroids, collision = 1

	// Generate a new asteroid randomly on line1[0]	
	// If no asteroid have been generated on line1[0]
	// Generate a new asteroid randomly on line0[0]

	// if spacecraft is up, print ">", else print = ">"
	// Print the output on the LCD
}

// TODO: This function is used to update the points
void updatePoints(){
	// See updateCountDown() for an example
}

// This function is used to update the countdown
void updateCountDown(){
	// If you use a cathod display, use the NOT (~)
	PORTD = map[digit0];
	RA0=1; // Enable 7-segment display
	sleep();
	RA0=0; // Enable 7-segment display

	PORTD = map[digit1];
	RA1=1; // Enable 7-segment display
	sleep();
	RA1=0; // Enable 7-segment display
}
// Helper function: wait for a while
void sleep(){
	for(int i = 0; i < 256; i++);
}
void initCountDown(){
    //timer settings
    T0CS=0;		//internal source
    PSA=0;		//enable prescaler
	//set prescaler
    PS2=1;	PS1=1;	PS0=1;
    
    T0IF=0;		//reset interrupt flag
    T0IE=1;		//enable timer interrupt

    divider=0;	//initialize divider
}

// TODO: This function is called as soon as the mission is finisched
void endMission(){
	// Update LCD with the final points and a message
}