#include <cs50.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
bool check_key(string s);
int main(int argc, string argv[])
{
    string ptext;
    if (argc != 2 || !check_key(argv[1]))
    {
        printf("Usage: ./caesar key\n");
        return 1;
       
    }
    int key = atoi(argv[1]);
    ptext = get_string("Plaintext: ");
    char cipher[strlen(ptext)];
    for (int k = 0; k <= strlen(ptext); k++)
    {
        if  (islower(ptext[k]))
        {
           cipher[k] = (((ptext[k] + key - 97) % 26) + 97);
        }
        else if (isupper(ptext[k]))
        {
            cipher[k] = (((ptext[k] + key - 65) % 26) + 65);
        }
        else
        {
        cipher[k] = ptext[k];
        }
    }
    printf("ciphertext: %s", cipher);
    printf("\n");
    return 0;
}
    



bool check_key(string s)
{
    for(int i=0;i<strlen(s);i++)
    
        if(!isdigit(s[i]))
        {
        return false;
        }
        return true;
}

