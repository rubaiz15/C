#include <cs50.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <math.h>
int word(int words, string text);
int letter(int letters, string text);
int sente(int sent, string text);
int main(void)

{
    float L = 0;
    float index = 0;
    float S = 0;
    int letters = 0;
    int words = 1;
    int sent = 0;
    string text = get_string("Type:");
    letter(letters, text);
    word(words, text);
    sente(sent, text);
    L = ((float) letter(letters, text) / word(words, text)) * 100;
    S = ((float) sente(sent, text) / word(words, text)) * 100;
    index = 0.0588 * L - 0.296 * S - 15.8;
    if (roundf(index) > 16)
    {
        printf("Grade 16+\n");
    }
    
    if (roundf(index) < 16 && roundf(index) > 1)
    {
    printf("Grade %.0f\n", roundf(index));
    }
    if (roundf(index) < 1)
    {
    printf("Before Grade 1\n");
}
}
    








int letter(int letters, string text)
{
    for( int i = 0; i < strlen(text); i++)
    {
    if ((text[i] >= 'a' && text[i] <= 'z') || (text[i] >= 'A' && text[i] <= 'Z'))
        {
         letters++;
        }
    }
return letters;
}




int word(int words, string text)
{
    for(int i = 0; i < strlen(text); i++)
    {
        if (text[i] == ' ')
        {
            words++;
        }
    }
    return words;
}

int sente(int sent, string text)
{
    for(int i = 0; i < strlen(text); i++)
    {
        if (text[i] == '.' || text[i] == '!' || text[i] == '?')
        {
            sent++;
        }
    }
    return sent;
}
    








