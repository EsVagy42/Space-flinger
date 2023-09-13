#include <gb/gb.h>
#include "Enemies.c"

uint8_t showIndex = 0;

void getInput(uint8_t input, fixed16* x, fixed16* y)
{
    switch (input & (J_UP | J_DOWN | J_LEFT | J_RIGHT))
    {
        case J_UP:
            *x = FIXED(0);
            *y = -INPUT_SPEED;
            break;
        case J_DOWN:
            *x = FIXED(0);
            *y = INPUT_SPEED;
            break;
        case J_LEFT:
            *x = -INPUT_SPEED;
            *y = FIXED(0);
            break;
        case J_RIGHT:
            *x = INPUT_SPEED;
            *y = FIXED(0);
            break;
        case J_UP | J_LEFT:
            *x = -INPUT_SPEED_DIAGONAL;
            *y = -INPUT_SPEED_DIAGONAL;
            break;
        case J_UP | J_RIGHT:
            *x = INPUT_SPEED_DIAGONAL;
            *y = -INPUT_SPEED_DIAGONAL;
            break;
        case J_DOWN | J_LEFT:
            *x = -INPUT_SPEED_DIAGONAL;
            *y = INPUT_SPEED_DIAGONAL;
            break;
        case J_DOWN | J_RIGHT:
            *x = INPUT_SPEED_DIAGONAL;
            *y = INPUT_SPEED_DIAGONAL;
            break;
        default:
            *x = FIXED(0);
            *y = FIXED(0);
    }
}


inline void showScore(uint8_t score[])
{
    for (showIndex = 0; showIndex < 6; showIndex++)
    {
        set_win_tile_xy(showIndex, 0, score[showIndex] + NUMBERS_OFFSET);
    }
}

inline void showLives(uint8_t lives[])
{
    set_win_tile_xy(17, 0, NUMBERS_OFFSET - 1);
    for (showIndex = 0; showIndex < 2; showIndex++)
    {
        set_win_tile_xy(showIndex + 18, 0, lives[showIndex] + NUMBERS_OFFSET);
    }
}

inline void showWave(uint8_t wave[])
{
    set_win_tile_xy(8, 0, NUMBERS_OFFSET - 2);
    for (showIndex = 0; showIndex < 2; showIndex++)
    {
        set_win_tile_xy(showIndex + 9, 0, wave[showIndex] + NUMBERS_OFFSET);
    }
}

inline void showTime(uint8_t time[])
{
    set_win_tile_xy(12, 0, NUMBERS_OFFSET - 3);
    for (showIndex = 0; showIndex < 2; showIndex++)
    {
        set_win_tile_xy(showIndex + 13, 0, time[showIndex] + NUMBERS_OFFSET);
    }
}

inline void addScore(uint8_t score[], uint8_t num)
{
    addBCD(score, lookup[num], 6);
}
