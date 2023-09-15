#include <gb/gb.h>
#include "Player.c"

enum SpaceshipType
{
    follower,
    spiraler
};

//how many points should a given spaceship earn
uint8_t SpaceshipPoints[] =
{
    0,
    1
};

typedef struct Enemy Enemy;

typedef struct Enemy
{
    GameObject gameObject;
    uint8_t accelerationShifts;
    uint8_t dragShifts;
    uint8_t deathTimer; //if it is set to something other than 0, the death animation is playing
    enum SpaceshipType type;
    uint8_t points;
    uint8_t enemyDisplayTile;
    void (*move) (Enemy*, Player*); //this is a pointer to a function that makes the enemy move
    void (*updateSprites) (Enemy*);
};

Enemy enemies[MAX_ENEMY_NUMBER]; //the enemies are stored in this
BOOLEAN activeEnemies[MAX_ENEMY_NUMBER]; //if the enemy in enemies at index is active or an open space for an enemy that needs to be loaded

//for loading enemies. it allocates the space for an enemy at the returned index in enemies or returns -1 if the allocation was unsuccessful
inline int8_t getAvailableEnemySpot()
{
    for (uint8_t i = 0; i < MAX_ENEMY_NUMBER; i++)
    {
        if (!activeEnemies[i])
        {
            activeEnemies[i] = TRUE;
            return i;
        }
    }
    return -1;
}




void moveFollower(Enemy* follower, Player* player)
{
    fixed16 x = sub(player->gameObject.posx, follower->gameObject.posx);
    fixed16 y = sub(player->gameObject.posy, follower->gameObject.posy);
    x = x >> follower->accelerationShifts;
    y = y >> follower->accelerationShifts;
    accelerateGameObject(&follower->gameObject, x, y);
    applyDragToGameObject(&follower->gameObject, follower->dragShifts);
}

void updateFollowerSprites(Enemy* follower)
{
    setRotatedSprite(follower->gameObject.firstSprite, 4, follower->gameObject.velx, follower->gameObject.vely);
}

void initFollower(uint8_t index, Player* player)
{
    Enemy* initEnemy = &enemies[index];

    initEnemy->accelerationShifts = 11;
    initEnemy->dragShifts = 4;
    initEnemy->gameObject.firstSprite = 2 + index;
    initEnemy->gameObject.spriteSizex = 1;
    initEnemy->gameObject.spriteSizey = 1;
    initEnemy->gameObject.posx = player->gameObject.posx + (index & 1 ? FIXED(80) : FIXED(-80));
    initEnemy->gameObject.posy = player->gameObject.posy + (index & 2 ? FIXED(80) : FIXED(-80));
    initEnemy->gameObject.velx = FIXED(0);
    initEnemy->gameObject.vely = FIXED(0);
    initEnemy->gameObject.collider.posx = enemies[index].gameObject.posx;
    initEnemy->gameObject.collider.posy = enemies[index].gameObject.posy;
    initEnemy->gameObject.collider.sizex = FIXED(8);
    initEnemy->gameObject.collider.sizey = FIXED(8);
    initEnemy->type = follower;
    initEnemy->deathTimer = 0;
    initEnemy->move = moveFollower;
    initEnemy->updateSprites = updateFollowerSprites;
}




void moveSpiralerPositive(Enemy* spiraler, Player* player)
{
    fixed16 x = sub(player->gameObject.posx, spiraler->gameObject.posx);
    fixed16 y = sub(player->gameObject.posy, spiraler->gameObject.posy);
    x = x >> spiraler->accelerationShifts;
    y = y >> spiraler->accelerationShifts;
    x += -(y >> 2);
    y += (x >> 1);
    accelerateGameObject(&spiraler->gameObject, x, y);
    applyDragToGameObject(&spiraler->gameObject, spiraler->dragShifts);
}

void moveSpiralerNegative(Enemy* spiraler, Player* player)
{
    fixed16 x = sub(player->gameObject.posx, spiraler->gameObject.posx);
    fixed16 y = sub(player->gameObject.posy, spiraler->gameObject.posy);
    x = x >> spiraler->accelerationShifts;
    y = y >> spiraler->accelerationShifts;
    x += (y >> 2);
    y += -(x >> 1);
    accelerateGameObject(&spiraler->gameObject, x, y);
    applyDragToGameObject(&spiraler->gameObject, spiraler->dragShifts);
}

void updateSpiralerSprites(Enemy* spiraler)
{
    setRotatedSprite(spiraler->gameObject.firstSprite, 13, spiraler->gameObject.velx, spiraler->gameObject.vely);
}

void initSpiralerPositive(uint8_t index, Player* player)
{
    Enemy* initEnemy = &enemies[index];

    initEnemy->accelerationShifts = 8;
    initEnemy->dragShifts = 4;
    initEnemy->gameObject.firstSprite = 2 + index;
    initEnemy->gameObject.spriteSizex = 1;
    initEnemy->gameObject.spriteSizey = 1;
    initEnemy->gameObject.posx = player->gameObject.posx + (index & 1 ? FIXED(80) : FIXED(-80));
    initEnemy->gameObject.posy = player->gameObject.posy + (index & 2 ? FIXED(80) : FIXED(-80));
    initEnemy->gameObject.velx = FIXED(0);
    initEnemy->gameObject.vely = FIXED(0);
    initEnemy->gameObject.collider.posx = enemies[index].gameObject.posx;
    initEnemy->gameObject.collider.posy = enemies[index].gameObject.posy;
    initEnemy->gameObject.collider.sizex = FIXED(8);
    initEnemy->gameObject.collider.sizey = FIXED(8);
    initEnemy->type = spiraler;
    initEnemy->deathTimer = 0;
    initEnemy->move = moveSpiralerPositive;
    initEnemy->updateSprites = updateSpiralerSprites;
}

void initSpiralerNegative(uint8_t index, Player* player)
{
    Enemy* initEnemy = &enemies[index];

    initEnemy->accelerationShifts = 8;
    initEnemy->dragShifts = 4;
    initEnemy->gameObject.firstSprite = 2 + index;
    initEnemy->gameObject.spriteSizex = 1;
    initEnemy->gameObject.spriteSizey = 1;
    initEnemy->gameObject.posx = player->gameObject.posx + (index & 1 ? FIXED(80) : FIXED(-80));
    initEnemy->gameObject.posy = player->gameObject.posy + (index & 2 ? FIXED(80) : FIXED(-80));
    initEnemy->gameObject.velx = FIXED(0);
    initEnemy->gameObject.vely = FIXED(0);
    initEnemy->gameObject.collider.posx = enemies[index].gameObject.posx;
    initEnemy->gameObject.collider.posy = enemies[index].gameObject.posy;
    initEnemy->gameObject.collider.sizex = FIXED(8);
    initEnemy->gameObject.collider.sizey = FIXED(8);
    initEnemy->type = spiraler;
    initEnemy->deathTimer = 0;
    initEnemy->move = moveSpiralerNegative;
    initEnemy->updateSprites = updateSpiralerSprites;
}



enum spaceShipFunctionsEnum
{
    followerInit,
    spiralerInitPositive,
    spiralerInitNegative
};

const void (*spaceShipFunctions[]) (uint8_t, Player*) =
{
    &initFollower,
    &initSpiralerPositive,
    &initSpiralerNegative
};

typedef struct Wave Wave;

typedef struct Wave
{
    uint8_t initFunctions[8];
    uint8_t enemyLoadDelay;
    uint8_t waveCountdown[2];
};

const Wave waves[] =
{
    {{followerInit, followerInit, followerInit, followerInit, followerInit, followerInit, followerInit, followerInit}, 180, {4, 0}},
    {{followerInit, followerInit, followerInit, followerInit, followerInit, followerInit, followerInit, followerInit}, 120, {3, 0}},
    {{followerInit, followerInit, followerInit, followerInit, followerInit, followerInit, spiralerInitPositive, spiralerInitNegative}, 180, {4, 0}},
    {{followerInit, followerInit, spiralerInitPositive, spiralerInitNegative, followerInit, followerInit, followerInit, followerInit}, 120, {3, 0}},
    {{followerInit, followerInit, followerInit, followerInit, followerInit, followerInit, followerInit, followerInit}, 60, {2, 0}},
    {{spiralerInitPositive, spiralerInitNegative, followerInit, followerInit, spiralerInitPositive, spiralerInitNegative, followerInit, followerInit}, 180, {4, 0}},
    {{spiralerInitPositive, spiralerInitNegative, spiralerInitPositive, spiralerInitNegative, spiralerInitPositive, spiralerInitNegative, spiralerInitPositive, spiralerInitNegative}, 240, {6, 0}},
    {{followerInit, followerInit, spiralerInitPositive, spiralerInitNegative, followerInit, followerInit, followerInit, followerInit}, 90, {3, 0}},
};