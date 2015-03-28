#include <iostream>
#include <stdlib.h>
#include <string>
#include <cstring>
#include <cstdlib>
#include <bitset>
#include <sstream>
#include "md5_pad.h"

using std::string;

typedef unsigned char ui8; 
typedef unsigned long long ui64;
typedef unsigned int ui32;

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

void md5_align (svBitVecVal ext[64], const char *mes, int size_from_sv) {
    std::string data = mes;
    std::string s = string_to_hex(data);

    ui64 bitLen = data.size() * 8;

    data += '\x80';

    size_t len = data.size();
    int l = 0;
    int num = len/4 + 1;
    char word[num][4];

    for (int i = 0; i < num; i++)
        if (len != 2)
            for (int j = 0; j < 4; j++) {
                word[i][3-j] = data[l];
                l++;
            }
        else {
            word[i][0] = word[i][1] = 0;
            word[i][2] = data[1];
            word[i][3] = data[0];
        }

    std::string md5Data;
    for (int i = 0; i < num; i++) {
        md5Data.append(word[i], 4);
    }

    len = md5Data.size();

    int rest = len % 64;
    rest = 56 - rest;

    if (rest < 0)
        rest = 64 + rest;

    md5Data.append(rest, 0);

    char lengthData[8] = {};
    char partLeft[4] = {};
    char partRight[4] = {};

    for (size_t i = 0; i < 8; ++i)
        lengthData[7-i] = (ui8)(bitLen >> i * 8);

    for (int i = 0; i < 4; i++) {
        partLeft[i] = lengthData[i];
        partRight[i] = lengthData[i+4];
    }

    md5Data.append(partRight, 4);
    md5Data.append(partLeft, 4);

    std::string str = string_to_hex(md5Data);

    for (int i = 0; i < 64; i++)
        ext[i] = md5Data[i];
    
    return;
}