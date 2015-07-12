#if !defined(__cplusplus)
#include <stdbool.h>
#endif
#include <stddef.h>
#include <stdint.h>
 
uint32_t encode_base_64(uint8_t *encoded, const char *src, uint32_t len);
uint8_t ascii_to_length(uint8_t *ascii_text);

struct frame {
	uint8_t start_byte;
	uint16_t data_length;
	uint8_t *data;
	uint8_t crc;
};

static inline void __raw_writel(uint32_t reg, uint32_t data)
{
	*(volatile uint32_t *)reg = data;
}
 
static inline uint32_t __raw_readl(uint32_t reg)
{
	return *(volatile uint32_t *)reg;
}
 
/* Loop <delay> times in a way that the compiler won't optimize away. */
static inline void delay(int32_t count)
{
	asm volatile("__delay_%=: subs %[count], %[count], #1; bne __delay_%=\n"
		 : : [count]"r"(count) : "cc");
}
 
size_t strlen(const char* str)
{
	size_t ret = 0;
	while ( str[ret] != 0 )
		ret++;
	return ret;
}
 
enum
{
    // The GPIO registers base address.
    GPIO_BASE = 0x20200000,
 
    // The offsets for reach register.
 
    // Controls actuation of pull up/down to ALL GPIO pins.
    GPPUD = (GPIO_BASE + 0x94),
 
    // Controls actuation of pull up/down for specific GPIO pin.
    GPPUDCLK0 = (GPIO_BASE + 0x98),
 
    // The base address for UART.
    UART0_BASE = 0x20201000,
 
    // The offsets for reach register for the UART.
    UART0_DR     = (UART0_BASE + 0x00),
    UART0_RSRECR = (UART0_BASE + 0x04),
    UART0_FR     = (UART0_BASE + 0x18),
    UART0_ILPR   = (UART0_BASE + 0x20),
    UART0_IBRD   = (UART0_BASE + 0x24),
    UART0_FBRD   = (UART0_BASE + 0x28),
    UART0_LCRH   = (UART0_BASE + 0x2C),
    UART0_CR     = (UART0_BASE + 0x30),
    UART0_IFLS   = (UART0_BASE + 0x34),
    UART0_IMSC   = (UART0_BASE + 0x38),
    UART0_RIS    = (UART0_BASE + 0x3C),
    UART0_MIS    = (UART0_BASE + 0x40),
    UART0_ICR    = (UART0_BASE + 0x44),
    UART0_DMACR  = (UART0_BASE + 0x48),
    UART0_ITCR   = (UART0_BASE + 0x80),
    UART0_ITIP   = (UART0_BASE + 0x84),
    UART0_ITOP   = (UART0_BASE + 0x88),
    UART0_TDR    = (UART0_BASE + 0x8C),
};
 
void uart_init()
{
	// Disable UART0.
	__raw_writel(UART0_CR, 0x00000000);
 
	// Setup the GPIO pin 14 && 15.
	// Disable pull up/down for all GPIO pins & delay for 150 cycles.
	__raw_writel(GPPUD, 0x00000000);
	delay(150);
 
	// Disable pull up/down for pin 14,15 & delay for 150 cycles.
	__raw_writel(GPPUDCLK0, (1 << 14) | (1 << 15));
	delay(150);
 
	// Write 0 to GPPUDCLK0 to make it take effect.
	__raw_writel(GPPUDCLK0, 0x00000000);
 
	// Clear pending interrupts.
	__raw_writel(UART0_ICR, 0x7FF);
 
	// Set integer & fractional part of baud rate.
	// Divider = UART_CLOCK/(16 * Baud)
	// Fraction part register = (Fractional part * 64) + 0.5
	// UART_CLOCK = 3000000; Baud = 115200.
 
	// Divider = 3000000 / (16 * 115200) = 1.627 = ~1.
	// Fractional part register = (.627 * 64) + 0.5 = 40.6 = ~40.
	__raw_writel(UART0_IBRD, 1);
	__raw_writel(UART0_FBRD, 40);
 
	// Enable FIFO & 8 bit data transmission (1 stop bit, no parity).
	__raw_writel(UART0_LCRH, (1 << 4) | (1 << 5) | (1 << 6));
 
	// Mask all interrupts.
	__raw_writel(UART0_IMSC, (1 << 1) | (1 << 4) | (1 << 5) | (1 << 6) |
	                       (1 << 7) | (1 << 8) | (1 << 9) | (1 << 10));
 
	// Enable UART0, receive & transfer part of UART.
	__raw_writel(UART0_CR, (1 << 0) | (1 << 8) | (1 << 9));
}
 
void uart_putc(unsigned char byte)
{
	// Wait for UART to become ready to transmit.
	while ( __raw_readl(UART0_FR) & (1 << 5) ) { }
	__raw_writel(UART0_DR, byte);
}
 
unsigned char uart_getc()
{
    // Wait for UART to have recieved something.
    while ( __raw_readl(UART0_FR) & (1 << 4) ) { }
    return __raw_readl(UART0_DR);
}
 
void uart_write(const unsigned char* buffer, size_t size)
{
	for ( size_t i = 0; i < size; i++ )
		uart_putc(buffer[i]);
}
 
void uart_puts(const char* str)
{
	uart_write((const unsigned char*) str, strlen(str));
}
 
#if defined(__cplusplus)
extern "C" /* Use C linkage for kernel_main. */
#endif
void kernel_main(uint32_t r0, uint32_t r1, uint32_t atags)
{
	struct frame fr;
	uint8_t /*c,*/ packet[260], encoded[260], data[255];
	uint8_t cnt = 0, len = 0, data_len[2];

	(void) r0;
	(void) r1;
	(void) atags; 

	uart_init();
	uart_puts("Hello, kernel World !! \r\n");
 
/*
	while ( c != '\n' ) {
		c = uart_getc();
		uart_putc(c+1);
	}
*/
retransmit:
	fr.start_byte = uart_getc();

	// Read the data length, MSB-LSB to get the data length
	data_len[0] = uart_getc();
	data_len[1] = uart_getc();
	fr.data_length = ascii_to_length(data_len);

#if 1
	packet[0] = fr.start_byte; // Start byte
	packet[1] = data_len[0]; // MSByte of length
	packet[2] = data_len[1]; // LSByte of length

//	len =  ascii_to_length(&(packet[1]));//(packet[1] << 8) | packet[2];
	uart_puts((const char *)packet);
#endif

	if (fr.start_byte != '$') {
		uart_puts("\nFrame dropped !! Invalid start byte \r\n");
		uart_puts("Requesting re-transmission \r\n");
		goto retransmit;
	}

	/* allocate memory */
	fr.data = data;

	// Recieve data bytes from Host system
	while ((cnt < fr.data_length)) {
		fr.data[cnt] = uart_getc();
		cnt++;
	}
	
	uart_puts("\n-----------\r\n");
	uart_puts((const char*)fr.data);
	uart_puts("\n--------------------\r\n");
	encode_base_64(encoded, (const char *)fr.data, cnt);
	uart_puts((const char*)encoded);

	while(1);
}

