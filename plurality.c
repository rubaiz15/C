#include <cs50.h>
#include <stdio.h>
#include <string.h>
#define MAX 9

typedef struct
{
    string name;
    int votes;
}
candidate;
int candidate_count;
candidate candidates[MAX];
bool vote(string name);
void print_winner(void);
int main(int argc, string argv[])
{
    candidate_count = argc - 1;
    if(argc > 10)
    {
    return 1;
    }
    
    for(int i = 0; i < candidate_count; i++)
    {
        candidates[i].name = argv[i+1];
        candidates[i].votes = 0;
    }
    int input_number = get_int("Number of Voters: ");
    for(int i = 0; i<input_number; i++)
    {
        string name = get_string("Vote: ");
        if((vote(name)) == false)
        {
            printf("Invalid Vote.");
        }
    }
    print_winner();
}






bool vote(string name)
{
    
    for(int i = 0; i<candidate_count; i++)
    {
        if (strcmp(candidates[i].name, name) == 0)
        {
            candidates[i].votes++;
            return true;
        }
    }
    return false;
    
}


void print_winner(void)
{
   int max=0;
    for(int i = 0;i < candidate_count;i++)
    {
        if (max < candidates[i].votes)
        {
            max = candidates[i].votes;
        }
    }
for (int i = 0; i < candidate_count; i++)
    {
        if (candidates[i].votes == max)
        {
            printf("%s\n", candidates[i].name);
        }
    }
    return;
}
