#include <pic.h>
#include "lcd.h"

__CONFIG(0x23E2);

// Using 8Mhz, we use 25 as an approximate divider
#define DIVIDER 25

#define EMPTY 0x20
#define ASTEROIDS 0x23
#define CHERRY 0x0


// 7-digit leds encoding
const unsigned char map[]={63,6,91,79,102,109,125,7,127,111};

#define ENDGAME 0x1
#define COLLISION 0x2
#define POSITION 0x4
#define UPDATE 0x8

// --- Global variables ---
unsigned char status = 0;       //Maskbit: ENDGAME[0], COLLISION[1], POSITION[2]

unsigned char divider = 0;			// helper variable for 
unsigned char digit0 = 0;				// first digit of the countdown
unsigned char digit1 = 0;				// second digit of the countdown

unsigned int points = 0;    //Points gained by the player.

char line0[16];            //Display Line 0
char line1[16];            //Display Line 1

unsigned char indexLines;  //We can actually use two direct memory pointer to be faster




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
            status |= UPDATE;
			if(digit0 == 0){
				if(digit1 == 0){
					// Both are zero: game finished
					status |= ENDGAME;
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



// TODO: This function is used to update the asteroids speed
void updateAsteroidsSpeed(){
	// Poll the value from the potentiometer, using the ADC
	
	// Normalize that value and store it in a global variable
}

void displayCountDown(){

}

void displayPoints(){

}

void displaySpace(){
    unsigned char index;
    //Position To begin of LCD
    lcd_goto(0x0);
    for (index = 0; index < 16; ++index){
        lcd_write(line0[index]);
    }
    for (index = 0; index < 16; ++index){
        lcd_write(line1[index]);
    }

}

unsigned char generateAsteroid(){
    return 1;
}


// TODO: This function is used to update the asteroids and LCD display
void updateSpace(){
	// ASSUMPTION: Use 2 "circular" buffers (one for each line) of 16 digits each (line1 and line0)	
	// ASSUMPTION: Use a binary value to store the position of the spacecraft (up or down)

    // If line1[15] contains an asteroids, points++;
    // If line0[15] contains an asteroids, points++;
    if(line0[indexLines] == ASTEROIDS || line1[indexLines] == ASTEROIDS){
        ++points;
    }

    // Generate a new asteroid randomly on line1[0] 
    // If no asteroid have been generated on line1[0]
    // Generate a new asteroid randomly on line0[0]
    unsigned char prevIndex 0;

    if (indexLines !=0){
        prevIndex  = indexLines-1;
    } else {
        prevIndex = 15;
    }

    if (generateAsteroid()){
        if(line1[prevIndex] !=  ASTEROIDS){
            line0[indexLines] = ASTEROIDS;
        } else {
            line0[indexLines] = EMPTY;
        }
        line1[indexLines] =  EMPTY;

    }else if(generateAsteroid()){
        if(line0[prevIndex] !=  ASTEROIDS){
            line1[indexLines] = ASTEROIDS;
        } else {
            line1[indexLines] = EMPTY;
        }
        line0[indexLines] =  EMPTY;
    } else {

        line0[indexLines] = EMPTY;
        line1[indexLines] = EMPTY;
    }

    // Update buffer index
    if (++indexLines > 15){
        indexLines = 0;
    }

    //Check collisions
    checkCollision();
	

	// if spacecraft is up, print ">", else print = ">"
	// Print the output on the LCD
}

void checkCollision(){
    // if spacecraft is up and line1[15] == asteroids, collision = 1
    // else
    // if spacecraft is up and line0[15] == asteroids, collision = 1
    if((status & POSITION) && line1[indexLines] == ASTEROIDS){
        status |= COLLISION;
    }   
    if(!(status & POSITION) && line0[indexLines] == ASTEROIDS){
        status |= COLLISION;
    }       
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


// --- Main ---
int main(){
    // port settings
    ANSEL=0x00;
    ANSELH=0x00;

    TRISD=0b00000000;   // PORTD used for 7-digits leds 

    initCountDown();
    
    GIE=1;      //enable all interrupts

    // --- main loop ---
    while(1){
        // Countdown reached 0 
        // or the spacecraft collided with an asteroid
        if (status & UPDATE){
            updateSpace();
            status &= ~UPDATE;
        }

        if(status & ENDGAME || status & COLLISION ){
            endMission();           // End mission
        }else{
            displayCountDown();     // Update countdown
            displayPoints();            // display points           
            displaySpace();         // display asteroids and show them on LCD display
            updateAsteroidsSpeed(); // Poll ADC: set asteroids speed        
        }
    }
}


