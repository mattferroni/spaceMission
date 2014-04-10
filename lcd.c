/*
 *   LCD interface example
 *   Uses routines from delay.c
 *   This code will interface to a standard LCD controller
 *   like the Hitachi HD44780. It uses it in 4 bit mode, with
 *   the hardware connected as follows (the standard 14 pin 
 *   LCD connector is used):
 *   
 *   PORTB bits 0-3 are connected to the LCD data bits 4-7 (high nibble)
 *   PORTB bit 4 is connected to the LCD RS input (register select)
 *   PORTA bit 5 is connected to the LCD EN bit (enable)
 *   
 *   To use these routines, set up the port I/O (TRISB) then
 *   call lcd_init(), then other routines as required.
 *   
 */

#ifndef _XTAL_FREQ
 // Unless specified elsewhere, 8MHz system frequency is assumed
 #define _XTAL_FREQ 8000000
#endif


#include   <htc.h>
#include   "lcd.h"

#define   LCD_RS RB4
#define LCD_EN RB5

#define LCD_DATA   PORTB

#define   LCD_STROBE()   ((LCD_EN = 1),(LCD_EN=0))

/* write a byte to the LCD in 4 bit mode */

void
lcd_write(unsigned char c)
{
   __delay_us(40);
   LCD_DATA = (LCD_DATA & 0xF0) | ( ( c >> 4 ) & 0x0F );
   LCD_STROBE();
   LCD_DATA = (LCD_DATA & 0xF0) | (c & 0x0F);
   LCD_STROBE();
   __delay_ms(5);
}

/*
 *    Clear and home the LCD
 */

void
lcd_clear(void)
{
   LCD_RS = 0;
   lcd_write(0x1);
   __delay_ms(5);
}

/* write a string of chars to the LCD */

void
lcd_puts(const char * s)
{
   LCD_RS = 1;   // write characters
   while(*s)
      lcd_write(*s++);
}

/* write one character to the LCD */

void
lcd_putch(char c)
{
   LCD_RS = 1;   // write characters
   lcd_write( c );
}


/*
 * Go to the specified position
 */

void
lcd_goto(unsigned char pos)
{
   LCD_RS = 0;
   lcd_write(0x80+pos);
}
   
/* initialise the LCD - put into 4 bit mode */
void
lcd_init()
{
   char init_value;

   init_value = 0x03;
   LCD_RS = 0;
   LCD_EN = 0;
   
   __delay_ms(15);   // wait 15mSec after power applied,
   LCD_DATA    = (LCD_DATA & 0xF0) | init_value;
   LCD_STROBE();
   __delay_ms(5);
   LCD_STROBE();
   LCD_DATA = 0x02;   // Four bit mode
   LCD_STROBE();
   __delay_ms(5);
   LCD_STROBE();
   __delay_ms(5);
   
   lcd_write(0x28); // Set interface length
   lcd_write(0x0C); // Display On, Cursor On, Cursor Blink
   lcd_clear();   // Clear screen
   lcd_write(0x6); // Set entry Mode
}

void LCD_build(unsigned char location, unsigned char *ptr){
   unsigned char i;
   if(location<8){
      LCD_RS = 0;
      lcd_write(0x40+(location*8));
      LCD_RS = 1;
      for(i=0;i<8;i++){
         lcd_write(ptr[i]);
      }
      }
    LCD_RS = 0;
    lcd_write(0x80);
}
