/**
 * @file lcd.h
 *	LCD interface header file
 *	See lcd.c for more info
 */


// DEFINE DEGLI INDIRIZZI DI RIGA

#define RIGA1 0
#define RIGA2 0x40

/** write a byte to the LCD in 4 bit mode */

extern void lcd_write(unsigned char);

/** Clear and home the LCD */

extern void lcd_clear(void);

/** write a string of characters to the LCD */

extern void lcd_puts(const char * s);

/** Go to the specified position */

extern void lcd_goto(unsigned char pos);
	
/** intialize the LCD - call before anything else */

extern void lcd_init(void);

extern void lcd_putch(char);

extern void LCD_build(unsigned char, unsigned char *);

/*	Set the cursor position */

#define	lcd_cursor(x)	lcd_write(((x)&0x7F)|0x80)