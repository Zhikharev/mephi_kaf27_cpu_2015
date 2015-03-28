#include <iostream>
#include <stdlib.h>
#include <string>>
#include <cstring>
#include <cstdlib>
#include <bitset>
#include "sha1_pad.h"

using std::string;
typedef unsigned char ui8;
typedef unsigned long long ui64;

std::string string_to_hex(const std::string& input)
{
    static const char* const lut = "0123456789ABCDEF";
    size_t len = input.length();

    std::string output;
    output.reserve(2 * len);
    for (size_t i = 0; i < len; ++i)
    {
        const unsigned char c = input[i];
        output.push_back(lut[c >> 4]);
        output.push_back(lut[c & 15]);
    }
    return output;
}

void sha1_align (svBitVecVal ext[64], const char* mes) {  
    std::string data = mes;
    std::string s = string_to_hex(data);
	ui64 bitLen = data.size() * 8;

    data += 0x80;

    size_t len = data.size();

    int rest = len % 64;
    rest = 56 - rest;

    if (rest < 0)
        rest = 64 + rest;

    data.append(rest, 0);

    char lengthData[8] = {};

    for (size_t i = 0; i < 8; ++i)
        lengthData[7-i] = (ui8)(bitLen >> i * 8);

    data.append(lengthData, 8);

    std::string str = string_to_hex(data);

    for (int i = 0; i < 64; i++)
        ext[i] = data[i];

    return;

}

