#include <stdbool.h>
#include "common.h"

uint32_t strlen(uint8_t *s)
{
    uint32_t len = 0;
    while (s[len] != 0)
        len++;
    return len;
}

void reverse_in_place(uint8_t *s)
{
    uint32_t len = strlen(s);
    uint8_t c;
    for (int ii = 0; ii < len / 2; ii++)
    {
        c = s[ii];
        s[ii] = s[len - ii - 1];
        s[len - ii - 1] = c;
    }
}

uint32_t int_to_ascii(int32_t n, char *s)
{
    uint32_t pos = 0;
    bool sign;

    if (sign = (n < 0))
        n = -n;

    do
    {
        s[pos++] = n % 10 + '0';
    } while ((n /= 10) > 0);

    if (sign)
        s[pos++] = '-';

    s[pos] = 0;
    reverse_in_place(s);
    return pos;
}