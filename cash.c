# include <cs50.h>
# include <stdio.h>
#include <math.h>
int main(void)
{
    int coin = 0;
    float cash = get_float("please input the amount owed in dollars:");
    int intcash = round(cash * 100);
    while (intcash != 0)
    {
        if (intcash >= 25)
        {
            intcash = intcash - 25;
            coin++;
        }
        if (intcash < 25 && intcash >= 10)
        {
            intcash = intcash - 10;
            coin++;
        }
        if (intcash < 10 && intcash >= 5)
        {
            intcash = intcash - 5;
            coin++;
        }
        if (intcash < 5 && intcash >= 1)
        {
            intcash = intcash - 1;
            coin++;
        }
        
    }
    printf("%i \n", coin);
}
