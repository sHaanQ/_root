
#include <stddef.h>
#include <stdint.h>
/*
 * Get a Two byte input in ASCII
 * convert it to Binary coded Hexadecimal
 *
 * @ascii_text - Two byte ASCII value
 * @bcd_value - Length equivalent of the ASCII input
 *
 */

uint8_t ascii_to_length(uint8_t *ascii_text)
{ 
	static uint8_t bcd_value;

    // MSB
    if(ascii_text[0] >= '0' && ascii_text[0] <= '9')
        bcd_value = (ascii_text[0] - '0')  << 4;
    else if (ascii_text[0] >= 'A' && ascii_text[0] <= 'F')
        bcd_value = (0xa + ascii_text[0] - 'A')  << 4;
    else if (ascii_text[0] >= 'a' && ascii_text[0] <= 'f')
        bcd_value = (0xa + ascii_text[0] - 'a')  << 4;

    // LSB
    if(ascii_text[1] >= '0' && ascii_text[1] <= '9')
        bcd_value |= (ascii_text[1] - '0');
    else if (ascii_text[1] >= 'A' && ascii_text[1] <= 'F')
        bcd_value |= (0xa + ascii_text[1] - 'A');
    else if (ascii_text[1] >= 'a' && ascii_text[1] <= 'f')
        bcd_value |= (0xa + ascii_text[1] - 'a');

	return bcd_value;
}
