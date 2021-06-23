#include <iostream>

uint16_t hashstring16(char* string) {
    unsigned int i = 0, len = strlen(string), hash = 0;
    unsigned char* work = (unsigned char*)string;
    uint16_t rethash;
    for (i = 0; i < len; i++) hash = (((hash << 0x05) | (hash >> 0x0B)) + work[i]) & 0xFFFF;
    rethash = hash & 0xFFFF;
    return rethash;
}

int main(int argc, char* argv[])
{
    if (argc < 2)
    {
        std::cout << "NO PARAMETERS GIVEN!\n";
    }
    else
    {
        char hex_string[20];
        sprintf_s(hex_string, "%X", hashstring16(argv[1]));
        std::cout << hex_string;
    }
}