#include <gb/gb.h>
#include "GameObject.c" //handles game objects
#include "Constants.c"

typedef struct Player Player;

typedef struct Player
{
    GameObject gameObject;
    uint8_t accelerationShifts;
    uint8_t dragShifts;
    uint8_t deathTimer; //if it is set to something other than 0, the death animation is playing
    uint8_t invincibilityTimer; //if it is set to something other than 0, the player is invincible
};

typedef struct Flinger Flinger;

typedef struct Flinger
{
    GameObject gameObject;
    uint8_t accelerationShifts;
    uint8_t dragShifts;
    BOOLEAN attached;
    BOOLEAN active;
};

inline void initPlayer(Player* player)
{
    player->gameObject.posx = FIXED(0);
    player->gameObject.posy = FIXED(0);
    player->gameObject.velx = FIXED(0);
    player->gameObject.vely = FIXED(0);
    player->gameObject.firstSprite = 0;
    player->gameObject.spriteSizex = 1;
    player->gameObject.spriteSizey = 1;
    player->accelerationShifts = 0;
    player->dragShifts = 5;
    player->gameObject.collider.posx = add(player->gameObject.posx, FIXED(2));
    player->gameObject.collider.posy = add(player->gameObject.posy, FIXED(2));
    player->gameObject.collider.sizex = FIXED(4);
    player->gameObject.collider.sizey = FIXED(4);
    player->deathTimer = 0;
    player->invincibilityTimer = INVINCIBILITY_FRAMES;
}

inline void initFlinger(Flinger* flinger)
{
    flinger->gameObject.posx = FIXED(0);
    flinger->gameObject.posy = FIXED(0);
    flinger->gameObject.velx = FIXED(0);
    flinger->gameObject.vely = FIXED(0);
    flinger->gameObject.firstSprite = 1;
    flinger->gameObject.spriteSizex = 1;
    flinger->gameObject.spriteSizey = 1;
    flinger->accelerationShifts = 5;
    flinger->dragShifts = ATTACHED_FLINGER_DRAG_SHIFTS;
    flinger->gameObject.collider.posx = flinger->gameObject.posx;
    flinger->gameObject.collider.posy = flinger->gameObject.posy;
    flinger->gameObject.collider.sizex = FIXED(8);
    flinger->gameObject.collider.sizey = FIXED(8);
    flinger->attached = TRUE;
    flinger->active = TRUE;
}