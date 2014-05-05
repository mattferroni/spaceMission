#include <pic.h>
#include "lcd.h"

__CONFIG(0x23E2);

// Using 8Mhz, we use 25 as an approximate divider
#define DIVIDER 25

#define LCD_RS RB4

#define CHERRYPOINTS 10

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
#define RANDOM 0x80

// --- Global variables ---
unsigned char status = 0;       //Maskbit: ENDGAME[0], COLLISION[1], POSITION[2]

unsigned char c1,c2,c3,c4;      //Charachter  LED Display

unsigned char refDivider = 25;

unsigned char updateDivider = 0;
unsigned char divider = 0;			// helper variable for 
unsigned char digit0 = 0;				// first digit of the countdown
unsigned char digit1 = 6;				// second digit of the countdown
unsigned char countdown = 60;
unsigned int points = 0;    //Points gained by the player.

char line0[16]="                ";            //Display Line 0
char line1[16]="                ";            //Display Line 1

unsigned char indexLines;  //We can actually use two direct memory pointer to be faster




// --- Interrupts handling ---
void interrupt isr(void) {
    //disable all interrupts
	GIE=0;
	

	// Timer interrupt: decrement the count down
    status |= RANDOM;

	if (T0IF == 1){
        T0IF=0;		//reset timer interrupt

        if (updateDivider==refDivider){
            updateDivider = 0;
            status |= UPDATE;
        }
        else {
            updateDivider++;
        }
        if (divider==DIVIDER){
            divider=0;
			if(countdown == 0){
    			status |= ENDGAME;
				}
			else {
				countdown--;	// Decrement digit 0
                c3 = (countdown/10) %10;
                c4 = countdown % 10;
            }
        }
        else
            divider++;
    }
    GIE=1; //enable all interrupt
}

// Helper function: wait for a while
void sleep(){
    for(int i = 0; i < 255; i++);
}

void displayDigits(){

    PORTD = map[c1];
    PORTA = ~0x08;
    sleep();
    PORTA = 0xFF;

    PORTD = map[c2];
    PORTA = ~0x04;
    sleep();
    PORTA = 0xFF;

    PORTD = map[c3];
    PORTA = ~0x02;
    sleep();
    PORTA = 0xFF;

    PORTD = map[c4];
    PORTA = ~0x01;
    sleep();
    PORTA = 0xFF;


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
	return (TMR0+(ADRESL >> 6) % 17)& 0x1;	
}

unsigned char generateCherry(){
    if ((TMR0 % 66 == 0)){
        return CHERRY;
    }
    return EMPTY;    
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

    if((status & POSITION) && line1[indexLines] == CHERRY){
        points += CHERRYPOINTS;
        line1[indexLines] = EMPTY;
    }   
    if(!(status & POSITION) && line0[indexLines] == CHERRY){
        points += CHERRYPOINTS;
        line1[indexLines] = EMPTY;
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
        c1 = (points/10) %10;
        c2 = points % 10;
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
            line0[indexLines] = generateCherry();
        }
        line1[indexLines] =  generateCherry();

    }else if(generateAsteroid()){
        if(line0[prevIndex] !=  ASTEROIDS){
            line1[indexLines] = ASTEROIDS;
        } else {
            line1[indexLines] = generateCherry();
        }
        line0[indexLines] =  generateCherry();
    } else {

        line0[indexLines] = generateCherry();
        line1[indexLines] = generateCherry();
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

int pow(int b, int exp){
    int res = 1;
    for (int i = 0; i<exp; ++i){
        res *= b;
    }
    return res;
}
// TODO: This function is called as soon as the mission is finisched
void endMission(){
    lcd_clear();
//    lcd_puts("   GameOver! \x04  ");
    char pointLine[16];
    char i = 0;
    int j;
    for (int p=points; p>0; p/=10){
        ++i;
    }

    for (j=0; j < i; ++j){
        pointLine[j] = '0' + (points/pow(10,(i-j-1)) %10);
    }

    pointLine[j++] = ' ';
    pointLine[j++] = 'P';
    pointLine[j++] = 't';
    if (points != 1)
        pointLine[j++] = 's';
    pointLine[j++] = 0;

    lcd_puts(pointLine);
    lcd_goto(0x40);
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

            // Poll ADC: set asteroids speed  
            if (GODONE == 0){

                 refDivider = ADRESH;

                 GODONE = 1;

            }


            displayDigits();    // display side digits
            displaySpace();         // display asteroids and show them on LCD display
        }
    }
}


