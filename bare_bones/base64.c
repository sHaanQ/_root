/*
 * Filename: 
 *
 * Description:
 *
 * Public functions:
 * 
 * Author:  Start date:
 *
 **/

#include <stddef.h>
#include <stdint.h>

#define DEBUG
#undef DEBUG

/* The Base64 index table */
static const char base64_lut[] =
"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

uint32_t encode_base_64(uint8_t *encoded, const char *src, uint32_t len)
{
	uint32_t i;
	uint8_t *p;

#ifdef DEBUG
	printf("%s\n", __func__);
	printf("%s %s\n", encoded, src);
#endif

	p = encoded;

	for (i = 0; i < len - 2; i += 3) {
		*p++ = base64_lut[(src[i] >> 2) & 0x3F];
		*p++ = base64_lut[((src[i] & 0x3) << 4) |
			((int) (src[i + 1] & 0xF0) >> 4)];
		*p++ = base64_lut[((src[i + 1] & 0xF) << 2) |
			((int) (src[i + 2] & 0xC0) >> 6)];
		*p++ = base64_lut[src[i + 2] & 0x3F];
	}

	if (i < len) {
		*p++ = base64_lut[(src[i] >> 2) & 0x3F];
		if (i == (len - 1)) {
			*p++ = base64_lut[((src[i] & 0x3) << 4)];
			*p++ = '=';
		}
		else {
			*p++ = base64_lut[((src[i] & 0x3) << 4) |
				((int) (src[i + 1] & 0xF0) >> 4)];
			*p++ = base64_lut[((src[i + 1] & 0xF) << 2)];
		}
		*p++ = '=';
	}

	*p++ = '\0';
	return (p - encoded);
}


