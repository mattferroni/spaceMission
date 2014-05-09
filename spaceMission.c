/**
 * @file spaceMission.c
 * @author Carminati, Ferroni, Martucci, Polino
 * @date 9 May 2014
 
 * @brief File containing implementation of spaceMission.
 */

/**
  * @mainpage
  * 
  * @image html gameover.png Game Over Screen
  * @image html screen.png Playing Screen
  * @image html cherry.png Cherry in the screen  
  * @image html 4digits.png Points and Countdown
  * @image html counter.png Count Down
  * @image html points.png Points  

  */


#include <pic.h>
#include "lcd.h"

__CONFIG(0x23E2);       ///< Configure PIC compiler

#define DIVIDER 25      ///< Approximate divider used to trigger a timer every second on a 8Mhz processor

#define LCD_RS RB4      ///< Pin used to enable the display

#define CHERRYPOINTS 10 ///< Points added when a cherry is catched by the spacecraft

/** @defgroup dis_char Display Characters
 * Characters mapped by LCD_build, to show icons on the screen
 *  @{
 */
#define EMPTY '\x20'        ///< Empty space referencecharacter
#define ASTEROIDS '\x02'    ///< Asteroids reference 
#define CHERRY '\x03'       ///< Cherry reference
#define SPACECRAFT '\x01'   ///< Spacecraft reference

const unsigned char cherry[]={0x2,0x4,0xe,0x15,0x11,0x11,0xe};          ///< Empty space character implementation
const unsigned char spacecraft[]={0x0,0x10,0x1c,0x1b,0x1c,0x10,0x0};    ///< Asteroids character implementation
const unsigned char asteroid[]={0x4,0xe,0x1e,0xf,0x1e,0x1c,0x4};        ///< Cherry character implementation
const unsigned char sad[]={0x0,0x2,0x14,0x4,0x14,0x2,0x0};              ///< Spacecraft character implementation
/** @} */ // end of dis_char

/** @defgroup status_bits Status Bits
 * The current status of the game is stored in a 8 bit char
 *  @{
 */
 unsigned char status = 0; ///< Mask of bits to store boolean variables of status of the game.
 
/**
  * The position is here defined
  */
#define ENDGAME 0x01    ///< First bit: 1 if the game ended
#define COLLISION 0x02  ///< Second bit: 1 if a collision has been detected
#define POSITION 0x04   ///< Third bit: 1 if the spacecraft is in the lower line of the screen
#define UPDATE 0x08     ///< Fourth bit: 1 if the screen need to be refreshed
/** @} */ // end of status_bits


/** @defgroup global_variable Global variables
 * The Global variables
 *  @{
 */
const unsigned char map[]={63,6,91,79,102,109,125,7,127,111}; ///< Map used to encode a 7-digits display

unsigned char c1;    ///< Character 1 to be written in the LED Display of 7 bits
unsigned char c2;    ///< Character 2 to be written in the LED Display of 7 bits
unsigned char c3;    ///< Character 3 to be written in the LED Display of 7 bits
unsigned char c4;    ///< Character 4 to be written in the LED Display of 7 bits

unsigned char refDivider = 25;      ///< Set the space updating speed  
unsigned char updateDivider = 0;    ///< Counter of timer interrupt related to #refDivider. 
unsigned char divider = 0;          ///< Counter of timer interrupt related to #DIVIDER

unsigned char countdown = 100;  ///< Countdown to the end of the game
unsigned int points = 0;    ///< Points gained by the player

char line0[16]="                ";  ///< Content of display Line 0
char line1[16]="                ";  ///< Content of display Line 1

unsigned char indexLines;  ///< Pointer of the circular buffer
/** @} */ // end of global_variable

/**
  * @brief Interrupts handling routine
  *
  * This routine is used to handle timing logic.
  * #updateDivider is incremented at every iteration until it reaches the #refDivider: the space environment is then shifted by one position.
  * #divider is incremented at every iteration until it reaches the #DIVIDER: the countdown time is then decremented by one
  */
void interrupt isr(void) {
    //disable all interrupts
    GIE=0;
    
    // Timer interrupt: decrement the count down
    if (T0IF == 1){
        T0IF=0;     //reset timer interrupt

        if (updateDivider>=refDivider){
            updateDivider = 0;
            status |= UPDATE;
        }
        else {
            updateDivider++;
        }
        if (divider>=DIVIDER){
            divider=0;
            if(countdown == 0){
                status |= ENDGAME;
                }
            else {
                countdown--;                // Decrement digit 0
                c3 = (countdown/10) % 10;
                c4 = countdown % 10;
            }
        }
        else
            divider++;
    }
    GIE=1; //enable all interrupt
}

/**
  * @brief Helper function, used to wait for a small period of time
  */
void sleep(){
    for(int i = 0; i < 255; i++);
}


/**
  * @brief Puts the digit representation of the value to be shown into the four 7-bit leds, using the #map array
  */
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

/**
  * @brief Puts the content of the space (#line0 and #line1) on the LCD display
  */
void displaySpace(){
    unsigned char index;

    lcd_goto(0x0);      // beginning of the LCD
    LCD_RS = 1;
    for(index=0; index < 16; ++index){  
        if(!(status & POSITION) && index == 0){
            lcd_write(SPACECRAFT);
        }else{
            lcd_write(line0[(index + indexLines) % 16]);
        }
    }
    lcd_goto(0x40);     // second line of the LCD
    LCD_RS = 1;
    for(index=0; index < 16; ++index){  
        if((status & POSITION) && index == 0){
            lcd_write(SPACECRAFT);
        }else{
            lcd_write(line1[(index + indexLines) % 16]);
        }
    }
}

/**
  * @brief Return 1 or 0 randomly (black magic), in order to generate or not a new asteroid.
  */
unsigned char generateAsteroid(){
    return (TMR0+(ADRESL >> 6) % 17)& 0x1;      // Very random. So difficult. Wow.
}

/**
  * @brief Return 1 or 0 randomly (black magic), in order to generate or not a new cherry.
  */
unsigned char generateCherry(){
    if ((TMR0 % 66 == 0)){
        return CHERRY;                          // Very sweet. Much fruit. Wow.
    }
    return EMPTY;    
}

/**
  * @brief Check for a collision with an asteroid or a cherry
  * The spacecraft collides with something if:
  * - it's in position 1 and there's an object in line 1;
  * - it's in position 0 and there's an object in line 0.
  * If the collision is with a cherry, #points are incremented by #CHERRYPOINTS
  */
void checkCollision(){

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


/**
  * @brief Update the asteroids and the score points 
  *  
  * This function use 2 "circular" buffers (one for each line) of 16 digits each (#line1 and #line0) 
  * -# Increments the points when an asteroids reach the end of the line. 
  * -# Generate a new asteroid randomly on #line0[#indexLines] if no asteroid have been 
  * generated on #line1[prevIndex] and vice-versa to avoid impossible paths for the spacecraft.
  * -# Generates randomly a cherry instead of an asteroids
  * -# Check for collisions
  */
void updateSpace(){
    // If line1[15] contains an asteroids, points++;
    // If line0[15] contains an asteroids, points++;
    if(line0[indexLines] == ASTEROIDS || line1[indexLines] == ASTEROIDS){
        ++points;
        c1 = (points/10) %10;
        c2 = points % 10;
    }

    unsigned char prevIndex = 0;
    if (indexLines !=0){
        prevIndex  = indexLines-1;
    }else{
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
}

/**
  * @brief Initialize timer, prescaler and interrupt stuff
  */
void initCountDown(){
    //timer settings
    T0CS=0;     //internal source
    PSA=0;      //enable prescaler
    //set prescaler
    PS2=1;  PS1=1;  PS0=1;
    
    T0IF=0;     //reset interrupt flag
    T0IE=1;     //enable timer interrupt
}

/**
  * Compute the power with base b and exponent exp (b^exp)
  * @param b base
  * @param exp exponent
  * @return b^e
  */
int pow(int b, int exp){
    int res = 1;
    for (int i = 0; i<exp; ++i){
        res *= b;
    }
    return res;
}

/**
  * Display a message after the end of the game. Shows points gained and a "Game Over" message.
  */
void endMission(){
    lcd_clear();
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


/**
  * Main of the program.
  * Initialize registers, clear the LCD display and initialize the countDown stuff.
  * The main loop:
  * -# displays asteroids and shows them on LCD display, if something changed;
  * -# checks if countdown reached 0 or the spacecraft collided with an asteroid;
  * -# checks if a button up has been pressed and pushes up the spacecraft;
  * -# checks if a button down has been pressed and pushes down the spacecraft;
  * -# polls the ADC to set asteroids speed; 
  * -# displays side digits (points and countDown).
  */
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

    GODONE = 1;

    initCountDown();

    GIE=1;      //enable all interrupts

    // --- main loop ---
    while(1){
        // Display asteroids and show them on LCD display, if something changed
        if (status & UPDATE){
            updateSpace();
            status &= ~UPDATE;
            displaySpace();       
        }

        // Countdown reached 0 or the spacecraft collided with an asteroid
        if(status & ENDGAME || status & COLLISION ){
            endMission();           // End mission
            while(1)
                sleep();
        }else{
            //Button up pressed: push up the spacecraft
            if (RB6){
                status &= ~POSITION;
                checkCollision();
                displaySpace();       
            }

            //Button down: pull down the spacecraft
            if (RB7){
                status |= POSITION;
                checkCollision();
                displaySpace();       
            }

            // Poll ADC: set asteroids speed  
            if (GODONE == 0){
                 refDivider = ADRESH;
                 GODONE = 1;
            }

            displayDigits();    // Display side digits (points and countDown)
        }
    }
}


