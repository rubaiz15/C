# include <cs50.h>
#include <stdio.h>
#include <math.h>
int main (void)
{
    int count=0;
long num;
    int digit = 0;
    int sum = 0;
    int i = 1;
    num= get_long("Enter the digits of a credit card number : ");

while(num!=0)
{
   
    num= num/10;
    count++;
    
}

    while (num > 0)
    {
        digit = num % 10;
        num = num / 10;



        if (i % 2 == 0 )
        {
            digit *= 2;
        }


        if (digit > 9)
        {
             digit = digit%10 + 1;
        }
        else
            digit *= 1;



        sum += digit;
        i++;
    }

    if(sum % 10 == 0) 
    {
      if(count==13)
      {
          printf("VISA\n");
      }
      if  (count==15)
      {
          printf("AMEX\n");
      }
      if  (count==16)
      {
          double last=0;
          int v1=10;
          int v2=15;
         if(num< 5*pow(v1, v2))
         {
             printf("VISA\n");
         }
          else 
         
          printf("MASTERCARD\n");
         
      }
    }
    
    
      else
      printf("INVALID\n");
    

}
    
    





  


