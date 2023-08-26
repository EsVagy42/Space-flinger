#include <gb/gb.h>
#include "fixed.c"

typedef struct
{
    fixed16 posx;
    fixed16 posy;
    fixed16 sizex;
    fixed16 sizey;
} Collider;

inline BOOLEAN checkCollision(Collider* a, Collider* b)
{
    return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
}

typedef struct
{
    fixed16 posx;
    fixed16 posy;
    fixed16 velx;
    fixed16 vely;

    Collider collider;

    int8_t firstSprite; //the index of the first sprite the object uses
    int8_t spriteSizex; //the number of sprites the game object uses horizontally
    int8_t spriteSizey; //the number of sprites the game object uses vertically
} GameObject;

void updateGameObject(GameObject *go, GameObject *player) //move the game object and its sprites by its velocity. the sprites are positioned relatively to the player
{
    go->posx = add(go->posx, go->velx);
    go->collider.posx = add(go->collider.posx, go->velx);
    go->posy = add(go->posy, go->vely);
    go->collider.posy = add(go->collider.posy, go->vely);
    
    if (go->spriteSizex == 1 && go->spriteSizey == 1)
    {
        move_sprite(go->firstSprite, INT(go->posx) - INT(player->posx) + 84, INT(go->posy) - INT(player->posy) + 84);
        return;
    }
    for (int y = 0; y < go->spriteSizey; y++)
    {
        for (int x = 0; x < go->spriteSizex; x++)
        {
            move_sprite(go->firstSprite + y * go->spriteSizex + x, INT(go->posx) + x * 8 - INT(player->posx) + 84, INT(go->posy) + y * 8 - INT(player->posy) + 84);
        }
    }
}

inline void accelerateGameObject(GameObject* go, fixed16 x, fixed16 y)
{
    go->velx = add(go->velx, x);
    go->vely = add(go->vely, y);
}

void applyDragToGameObject(GameObject* go, int8_t dragRatioShifts)
{
    if (go->velx != 0)
    {
        fixed16 shiftedx = go->velx >> dragRatioShifts;
        go->velx = sub(go->velx, shiftedx != 0 ? shiftedx : 1);
    }
    if (go->vely != 0)
    {
        fixed16 shiftedy = go->vely >> dragRatioShifts;
        go->vely = sub(go->vely, shiftedy != 0 ? shiftedy : 1);
    }
}

void setRotatedSprite(int8_t sprite, int8_t tile, fixed16 x, fixed16 y)
{
    if (x == FIXED(0) && y == FIXED(0))
    {
        return;
    }
    BOOLEAN xsmaller = abs(x) < abs(y);
    if ((abs(xsmaller ? x : y) << 1) < abs(xsmaller ? y : x))
    {
        if (xsmaller)
        {
            set_sprite_tile(sprite, tile);
            set_sprite_prop(sprite, y > 0 ? S_FLIPY : 0);
        }
        else
        {
            set_sprite_tile(sprite, tile + 2);
            set_sprite_prop(sprite, x > 0 ? S_FLIPX : 0);
        }
    }
    else
    {
        set_sprite_tile(sprite, tile + 1);
        set_sprite_prop(sprite, (x > 0 ? S_FLIPX : 0) | (y > 0 ? S_FLIPY : 0));
    }
}

inline void moveBackground(GameObject* player) //move the background relative to the player
{
    move_bkg(INT(player->posx), INT(player->posy));
}