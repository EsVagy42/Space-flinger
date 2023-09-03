#include <gb/gb.h>
#include "Enemies.c"

void getInput(uint8_t input, fixed16* x, fixed16* y)
{
    *x = FIXED(0);
    *y = FIXED(0);

    if (input & J_UP)
    {
        *y = -INPUT_SPEED;
    }
    if (input & J_DOWN)
    {
        *y = INPUT_SPEED;
    }
    if (input & J_LEFT)
    {
        *x = -INPUT_SPEED;
    }
    if (input & J_RIGHT)
    {
        *x = INPUT_SPEED;
    }

    if (*x != 0 && *y != 0)
    {
        *x = *x > 0 ? INPUT_SPEED_DIAGONAL : -INPUT_SPEED_DIAGONAL;
        *y = *y > 0 ? INPUT_SPEED_DIAGONAL : -INPUT_SPEED_DIAGONAL;
    }
}

inline void showScore(uint8_t score[])
{
    for (uint8_t i = 0; i < 6; i++)
    {
        set_win_tile_xy(i + 1, 0, score[i] + NUMBERS_OFFSET);
    }
}

inline void showLives(uint8_t lives[])
{
    set_win_tile_xy(18, 0, NUMBERS_OFFSET - 1);
    for (uint8_t i = 0; i < 2; i++)
    {
        set_win_tile_xy(i + 19, 0, lives[i] + NUMBERS_OFFSET);
    }
}

inline void addScore(uint8_t score[], uint8_t num)
{
    uint8_t lookup[7][8] = {
        {0, 0, 0, 0, 1, 0},
        {0, 0, 0, 0, 2, 5},
        {0, 0, 0, 0, 5, 0},
        {0, 0, 0, 1, 0, 0},
        {0, 0, 0, 2, 5 ,0},
        {0 ,0 ,0 ,5 ,0 ,0},
        {0 ,0 ,1 ,0 ,0 ,0}
    };

    uint8_t *addScore = lookup[num];

    addBCD(score, addScore, 6);
}
