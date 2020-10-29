#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <math.h>
#define MAX 9
#define MAX_VOTERS 100
#define MAX_CANDIDATES 9
int preferences [MAX_VOTERS][MAX_CANDIDATES];
typedef struct
{
    string name;
    int votes;
    bool eliminated;
}
candidate;
candidate candidates[MAX_CANDIDATES];
int candidate_count;
int voter_count;
//functions
bool vote (int voter, int rank, string name);
void tabulate (void);
bool print_winner (void);
int find_min (void);
bool is_tie (int min);
void eliminate (int min);
//main function
int main ( int argc, string argv[] )
{
    if ( argc > 10 && argc < 2 )//candidate limit
    {
        return 1;
    }
    candidate_count = argc - 1;//global variable
    //transfer from argv to candidate data type
    for( int i = 0; i < candidate_count; i++ )
    {
        candidates[i].name = argv[i + 1];
        candidates[i].votes = 0;
        candidates[i].eliminated = false;
    }
    voter_count = get_int("Number of voters:");
    for(int i = 0;i < voter_count; i++)
    {
        for( int j = 0;j < candidate_count; j++)
        {//input for vote and declaring valid or invalid
            string name = get_string("rank %i: ", j + 1);
            if(!vote(i,j,name))
            {
            printf("invalid vote\n");
            return 5;
            }
            
        }
        printf("\n");
    }
    while(true)
    {
    tabulate();
    bool winner= print_winner();
    if(winner)
    {
        break;
    }
    int min = find_min();
    bool tie = is_tie(min);
    if (tie)
    {
        for(int i = 0; i < candidate_count; i++)
        {
            if(!candidates[i].eliminated)
            {
                printf("%s\n", candidates[i].name);
            }
        }
        break;
    }
    
    eliminate(min);
    for(int i = 0;i < candidate_count; i++)
    {
        candidates[i].votes = 0;
    }
}
return 0;
}
















// function vote
bool vote( int voter, int rank, string name )
{
    bool present = false;
for(int i = 0;i < candidate_count; i++)
{
    if(strcmp(name, candidates[i].name) == 0)
    {
        preferences[voter][rank] = i;
        present = true;
        break;
    }
}
return present;
}





//tabulate function
void tabulate (void)
{
    for(int i = 0; i < voter_count; i++)
    {
        for( int j = 0; j < candidate_count; j++)
        {
            if( candidates[preferences[i][j]].eliminated == false)
            {
               candidates[preferences[i][j]].votes += 1;
               break;
            }
    }
    
}
return;
}
//print_winner
bool print_winner (void)
{

    for(int i = 0; i < candidate_count; i++)
    {
        string maj = candidates[i].name;
        if(candidates[i].votes > voter_count / 2)
       {
        printf("%s\n", maj);
        return true;
       }
    }
        return false;

}

//find_min
int find_min (void)
{
    int min = voter_count;
    for(int i = 0; i < candidate_count; i++)
    {
        if(candidates[i].eliminated == false && candidates[i].votes < min)
        {
            min = candidates[i].votes;
        }
    }
    return min;
}
//is_tie function
bool is_tie (int min)
{
    for(int i = 0; i < candidate_count; i++)
    {
        if(candidates[i].eliminated == false && candidates[i].votes != min)
        {
            return false;
        }
    }
    return true;
}
//eliminate function
void eliminate (int min)
{
    for(int i = 0;i < candidate_count; i++)
    {
    if(candidates[i].votes == min)
      {
        candidates[i].eliminated = true;
      }
    }
    return;
}














