#include <gb/gb.h>
#include "Player.c"
#include "Additionalfunctions.c"

enum SpaceshipType
{
    follower
};

//how many points should a given spaceship earn
uint8_t SpaceshipPoints[] =
{
    0
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
    void (*move) (Enemy*, Player*); //this is a pointer to a function that makes the enemy move
    void (*updateSprites) (Enemy*);
};

Enemy enemies[maxEnemyNumber]; //the enemies are stored in this
BOOLEAN activeEnemies[maxEnemyNumber]; //if the enemy in enemies at index is active or an open space for an enemy that needs to be loaded

//for loading enemies. it allocates the space for an enemy at the returned index in enemies or returns -1 if the allocation was unsuccessful
inline int8_t loadEnemy()
{
    for (uint8_t i = 0; i < maxEnemyNumber; i++)
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
    initEnemy->gameObject.posx = player->gameObject.posx;
    initEnemy->gameObject.posy = sub(player->gameObject.posy, FIXED(80));
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