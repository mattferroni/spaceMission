#include <pic.h>
#include "lcd.h"

__CONFIG(0x23E2);

// Using 8Mhz, we use 25 as an approximate divider
#define DIVIDER 25

#define LCD_RS RB4

//Characters mapped by LCD_build
#define EMPTY '\x20'
#define ASTEROIDS '\x02'
#define CHERRY '\x03'
#define SPACECRAFT '\x01'

// 7-digit leds encoding
const unsigned char map[]={63,6,91,79,102,109,125,7,127,111};
const unsigned char cherry[]={0x2,0x4,0xe,0x15,0x11,0x11,0xe};
const unsigned char spacecraft[]={0x0,0x10,0x1c,0x1b,0x1c,0x10,0x0};
const unsigned char asteroid[]={0x4,0xe,0x1e,0xf,0x1e,0x1c,0x4};
const unsigned char sad[]={0x0,0x2,0x14,0x4,0x14,0x2,0x0};

#define ENDGAME 0x01
#define COLLISION 0x02
#define POSITION 0x04
#define UPDATE 0x08
#define UPDATESPEED 0x10
#define RANDOM 0x80

// --- Global variables ---
unsigned char status = 0;       //Maskbit: ENDGAME[0], COLLISION[1], POSITION[2]

unsigned char refDivider = 25;

unsigned char updateDivider = 0;
unsigned char divider = 0;			// helper variable for 
unsigned char digit0 = 0;				// first digit of the countdown
unsigned char digit1 = 0;				// second digit of the countdown

unsigned int points = 0;    //Points gained by the player.

char line0[16]="                ";            //Display Line 0
char line1[16]="                ";            //Display Line 1

unsigned char indexLines;  //We can actually use two direct memory pointer to be faster




// --- Interrupts handling ---
void interrupt isr(void) {
    //disable all interrupts
	GIE=0;
	
     if (ADIF ==  1){
        
         ADIF = 0;
        
         refDivider = ADRESH;
         status |= UPDATESPEED;

        GODONE = 1;
    }


	// Timer interrupt: decrement the count down
	else if (T0IF == 1){
        T0IF=0;		//reset timer interrupt
        status |= RANDOM;

        if (updateDivider==refDivider){
            updateDivider = 0;
            status |= UPDATE;
        }
        else
            updateDivider++;

        if (divider==DIVIDER){
            divider=0;
			if(digit0 == 0){
				if(digit1 == 0){
					// Both are zero: game finished
//					status |= ENDGAME;
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

// Helper function: wait for a while
void sleep(){
    for(int i = 0; i < 1255; i++);
}


// TODO: This function is used to update the asteroids speed
void updateAsteroidsSpeed(){
	// Poll the value from the potentiometer, using the ADC
	
	// Normalize that value and store it in a global variable
}

void displayCountDown(){
    char c1,c2,c3,c4;
    c1 = 1;
    c2 = 0;
    c3 = 2;
    c4 = 4;

    PORTD = map[(refDivider/1000) %10];
    PORTA = ~0x08;
    sleep();
    PORTA = 0xFF;

    PORTD = map[(refDivider/100) %10];
    PORTA = ~0x04;
    sleep();
    PORTA = 0xFF;

    PORTD = map[(refDivider/10) %10];
    PORTA = ~0x02;
    sleep();
    PORTA = 0xFF;

    PORTD = map[refDivider %10];
    PORTA = ~0x01;
    sleep();
    PORTA = 0xFF;


}

void displayPoints(){

}

void displaySpace(){
    unsigned char index;

	lcd_goto(0x0);
	LCD_RS = 1;
	for(index=0; index < 16; ++index){	
		if(!(status & POSITION) && index == 0){
			lcd_write(SPACECRAFT);
		}else{
			lcd_write(line0[(index + indexLines) % 16]);
		}
	}
	lcd_goto(0x40);
	LCD_RS = 1;
	for(index=0; index < 16; ++index){	
		if((status & POSITION) && index == 0){
			lcd_write(SPACECRAFT);
		}else{
			lcd_write(line1[(index + indexLines) % 16]);
		}
	}
}

unsigned char generateAsteroid(){
	return (TMR0 % 11)& 0x1;	
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
    unsigned char prevIndex = 0;

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
    lcd_clear();
    lcd_puts("   GameOver! \x04  ");
	// Update LCD with the final points and a message
}


// --- Main ---
int main(){
    // port settings
   INTCON = 0;
   ANSEL = 0b00010000;
   ANSELH = 0x0;

   TRISA = 0b11110000;
   TRISB = 0b11000000;
   TRISC = 0xFF;
   TRISD = 0b00000000;   // PORTD used for 7-digits leds 
   TRISE = 0XFF;

   PORTA = 0x0;

    //ADC init
    ADFM=0; //ADRESH stores conversion MSB 
    //set Fosc/32 
    ADCS1=1; ADCS0=0; 
    //ADC reference: Vdd and GND 
    VCFG0 = 0; VCFG1 = 0; 
    //ADC Enable 
    ADON = 1; 
    //Channel selection (AN 4)
    CHS0 = 0; CHS1 = 0; CHS2 = 1; CHS3 = 0;




	lcd_init();
	lcd_clear();
	lcd_puts("Welcome");

    LCD_build(1,spacecraft);
    LCD_build(2,asteroid);
    LCD_build(3,cherry);
    LCD_build(4,sad);


    initCountDown();
    

    PEIE = 1; //enable peripherals interrupts 
    ADIE = 1; //enable ADC interrupt 
    ADIF = 0; //reset flag

    GIE=1;      //enable all interrupts

    GODONE = 1;

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
            while(1)
                sleep();
        }else{
            //Button up pressed: push up the spacecraft
            if (RB6){
                status &= ~POSITION;
                checkCollision();
            }

            //Button down: pull down the spacecraft
            if (RB7){
                status |= POSITION;
                checkCollision();
            }
            if (status & UPDATESPEED){
                displayCountDown();     // Update countdown
                status &= ~UPDATESPEED;
            }
            displayPoints();            // display points           
            displaySpace();         // display asteroids and show them on LCD display
            updateAsteroidsSpeed(); // Poll ADC: set asteroids speed        
        }
    }
}


