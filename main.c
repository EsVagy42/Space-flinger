#include <gb/gb.h>
#include "GameObject.c" //handles game objects
#include "Assets/Spaceships.c"  //sprite tiles
#include "Assets/Space.c" //background tiles
#include "Assets/SpaceMap.c" //background map

#define maxEnemyNumber 8 //number of enemies allowed

#define flingerDistance FIXED(13) //if the flinger gets closer to the spaceship than this, it will be repelled

#define explosionFrames 20 //for animation
#define pointFrames 30  //for animation
#define totalAnimationFrames (explosionFrames + pointFrames) //total number of animated frames when an enemy explodes
#define playerDeathHaltFrames 120 //after the player dying the game will halt for that many frames 
#define pointOffset 121 //from which tile number the point tiles begin
#define numbersOffset 118 //from which tile number the number tiles begin
#define explosionOffset 7 //from which tile number the explosion tiles begin
#define explosionAnimationFrames 5 //how many frames of animation the explosion effect uses

#define invincibilityFrames 120 //after death the player is invincible for that many frames

#define inputSpeed FIXED(.3) //this number is output by the getInput function for x or y
#define inputSpeedDiagonal FIXED(.2121) //this number is output by the getInput function for x or y if more than one direction is pressed

#define attachedFlingerDragShifts 4
#define detachedFlingerDragShifts 6

enum SpaceshipType
{
    follower
};

//how many points should a given spaceship earn
uint8_t SpaceshipPoints[] =
{
    0
};

typedef struct
{
    GameObject gameObject;
    uint8_t accelerationShifts;
    uint8_t dragShifts;
    uint8_t deathTimer; //if it is set to something other than 0, the death animation is playing
    enum SpaceshipType type;
    uint8_t points;
    void* move;
} Enemy;


void getInput(uint8_t input, fixed16* x, fixed16* y)
{
    *x = FIXED(0);
    *y = FIXED(0);

    if (input & J_UP)
    {
        *y = -inputSpeed;
    }
    if (input & J_DOWN)
    {
        *y = inputSpeed;
    }
    if (input & J_LEFT)
    {
        *x = -inputSpeed;
    }
    if (input & J_RIGHT)
    {
        *x = inputSpeed;
    }

    if (*x != 0 && *y != 0)
    {
        *x = *x > 0 ? inputSpeedDiagonal : -inputSpeedDiagonal;
        *y = *y > 0 ? inputSpeedDiagonal : -inputSpeedDiagonal;
    }
}

inline void showScore(uint8_t score[])
{
    for (uint8_t i = 0; i < 6; i++)
    {
        set_win_tile_xy(i + 1, 0, score[i] + numbersOffset);
    }
}

inline void showLives(uint8_t lives[])
{
    set_win_tile_xy(18, 0, numbersOffset - 1);
    for (uint8_t i = 0; i < 2; i++)
    {
        set_win_tile_xy(i + 19, 0, lives[i] + numbersOffset);
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

typedef struct
{
    GameObject gameObject;
    uint8_t accelerationShifts;
    uint8_t dragShifts;
    uint8_t deathTimer; //if it is set to something other than 0, the death animation is playing
    uint8_t invincibilityTimer; //if it is set to something other than 0, the player is invincible
} Player;

typedef struct
{
    GameObject gameObject;
    uint8_t accelerationShifts;
    uint8_t dragShifts;
    BOOLEAN attached;
} Flinger;

Enemy enemies[maxEnemyNumber]; //the enemies are stored in this
BOOLEAN activeEnemies[maxEnemyNumber]; //if the enemy in enemies at index is active or an open space for an enemy that needs to be loaded
uint8_t enemyUpdate = 0; //used for checking if an enemy needs to be updated in the current frame. Enemies are updated every 4th frame to save on cpu usage

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

void main()
{

    SHOW_SPRITES;
    SHOW_BKG;
    SHOW_WIN;

    move_win(0, 136); //for the HUD

    //scores and lives are held in Binary Coded Decimal. every digit gets stored in an uint8_t value
    uint8_t score[6] = {0, 0, 0, 0, 0, 0};
    uint8_t lives[2] = {0, 3};

    uint8_t enemyTimer = 1; //if it reaches 0, an enemy is loaded and is reset to resetEnemyTimer
    uint8_t resetEnemyTimer = 255;

    OBP0_REG = 0x1B; //for setting the sprite palette

    set_sprite_data(0, 128, SpaceShipTiles);

    set_sprite_tile(0, 0); //player

    set_sprite_tile(1, 3); //flinger

    set_bkg_data(0, 128, SpaceTiles);

    set_bkg_tiles(0, 0, 32, 32, SpaceMap);

    //initializing the player
    Player player;
    player.gameObject.posx = FIXED(0);
    player.gameObject.posy = FIXED(0);
    player.gameObject.velx = FIXED(0);
    player.gameObject.vely = FIXED(0);
    player.gameObject.firstSprite = 0;
    player.gameObject.spriteSizex = 1;
    player.gameObject.spriteSizey = 1;
    player.accelerationShifts = 0;
    player.dragShifts = 5;
    player.gameObject.collider.posx = add(player.gameObject.posx, FIXED(2));
    player.gameObject.collider.posy = add(player.gameObject.posy, FIXED(2));
    player.gameObject.collider.sizex = FIXED(4);
    player.gameObject.collider.sizey = FIXED(4);
    player.deathTimer = 0;
    player.invincibilityTimer = invincibilityFrames;

    //initializing the flinger
    Flinger flinger;
    flinger.gameObject.posx = FIXED(0);
    flinger.gameObject.posy = FIXED(0);
    flinger.gameObject.velx = FIXED(0);
    flinger.gameObject.vely = FIXED(0);
    flinger.gameObject.firstSprite = 1;
    flinger.gameObject.spriteSizex = 1;
    flinger.gameObject.spriteSizey = 1;
    flinger.accelerationShifts = 6;
    flinger.dragShifts = attachedFlingerDragShifts;
    flinger.gameObject.collider.posx = flinger.gameObject.posx;
    flinger.gameObject.collider.posy = flinger.gameObject.posy;
    flinger.gameObject.collider.sizex = FIXED(8);
    flinger.gameObject.collider.sizey = FIXED(8);
    flinger.attached = TRUE;

    while(1)
    {
        fixed16 x;
        fixed16 y;
        if (player.deathTimer == 0) //that means the player is alive
        {
            uint8_t input = joypad();
            if (input & J_A)
            {
                flinger.attached = FALSE;
                flinger.dragShifts = detachedFlingerDragShifts;
            }
            getInput(input, &x, &y);
            accelerateGameObject(&player.gameObject, x, y);
            setRotatedSprite(0, 0, x, y);
        }
        else
        {
            if (player.deathTimer > playerDeathHaltFrames) //the death animation is playing
            {
                set_sprite_tile(player.gameObject.firstSprite,
                    (explosionAnimationFrames - ((player.deathTimer - playerDeathHaltFrames) >> 2)) + explosionOffset);
                applyDragToGameObject(&player.gameObject, player.dragShifts);
            }
            player.deathTimer--;
            if (!player.deathTimer)
            {
                uint8_t subLives[] = {0, 1};
                subBCD(lives, subLives, 2);
                player.invincibilityTimer = invincibilityFrames;
            }
        }
        applyDragToGameObject(&player.gameObject, player.dragShifts);

        if (flinger.attached)
        {
            x = sub(player.gameObject.posx, flinger.gameObject.posx);
            y = sub(player.gameObject.posy, flinger.gameObject.posy);
            if (abs(x) + abs(y) < flingerDistance) //flinger is repelled because it is too close to the player
            {
                x = -x;
                y = -y;
                if (flinger.gameObject.velx == 0 && flinger.gameObject.vely == 0)
                {
                    flinger.gameObject.velx = FIXED(.1);
                    flinger.gameObject.vely = FIXED(.1);
                }
            }
            x = x >> flinger.accelerationShifts;
            y = y >> flinger.accelerationShifts;
            accelerateGameObject(&flinger.gameObject, x, y);
        }
        else
        {
            if (checkCollision(&player.gameObject.collider, &flinger.gameObject.collider))
            {
                flinger.attached = TRUE;
                flinger.dragShifts = attachedFlingerDragShifts;
            }
        }
        applyDragToGameObject(&flinger.gameObject, flinger.dragShifts);
        updateGameObject(&flinger.gameObject, &player.gameObject);

        //updating the enemies
        for (uint8_t i = 0; i < maxEnemyNumber; i++)
        {
            if (activeEnemies[i])
            {
                if (enemies[i].deathTimer == 0) //the enemy is alive
                {
                    if (checkCollision(&enemies[i].gameObject.collider, &flinger.gameObject.collider))
                    {
                        enemies[i].deathTimer = totalAnimationFrames;
                        enemies[i].gameObject.spriteSizex = 1;
                        enemies[i].gameObject.spriteSizey = 1;
                        enemies[i].points = SpaceshipPoints[enemies[i].type] + (flinger.attached ? 0 : 1);
                        set_sprite_prop(enemies[i].gameObject.firstSprite, 0);
                        set_sprite_tile(enemies[i].gameObject.firstSprite, explosionOffset);
                        enemies[i].gameObject.velx = flinger.gameObject.velx;
                        enemies[i].gameObject.vely = flinger.gameObject.vely;
                        updateGameObject(&enemies[i].gameObject, &player.gameObject);
                    }
                    else
                    {
                        if (i == enemyUpdate || i == enemyUpdate + (maxEnemyNumber >> 1)) //the enemy should be updated in the current frame
                        {
                            //TODO: this should be replaced by enemy.move
                            x = sub(player.gameObject.posx, enemies[i].gameObject.posx);
                            y = sub(player.gameObject.posy, enemies[i].gameObject.posy);
                            x = x >> enemies[i].accelerationShifts;
                            y = y >> enemies[i].accelerationShifts;
                            accelerateGameObject(&enemies[i].gameObject, x, y);
                            applyDragToGameObject(&enemies[i].gameObject, enemies[i].dragShifts);
                            setRotatedSprite(2 + i, 4, x, y);
                        }
                        updateGameObject(&enemies[i].gameObject, &player.gameObject);
                    }
                }
                else //enemy death animation showing
                {
                    enemies[i].deathTimer--;
                    if (!enemies[i].deathTimer)
                    {
                        activeEnemies[i] = FALSE;
                        hide_sprite(enemies[i].gameObject.firstSprite);
                    }
                    else
                    {
                        if (enemies[i].deathTimer == pointFrames) //the score for the enemy should begin showing this frame
                        {
                            addScore(score, enemies[i].points);
                            set_sprite_tile(enemies[i].gameObject.firstSprite, pointOffset + enemies[i].points);
                        }
                        else if (enemies[i].deathTimer < pointFrames) //the score for the enemy is being displayed
                        {
                            scroll_sprite(enemies[i].gameObject.firstSprite, 0, -1);
                        }
                        else //the death animation is showing
                        {
                            set_sprite_tile(enemies[i].gameObject.firstSprite,
                            (explosionAnimationFrames - ((enemies[i].deathTimer - pointFrames) >> 2)) + explosionOffset);
                            applyDragToGameObject(&enemies[i].gameObject, enemies[i].dragShifts);
                            scroll_sprite(enemies[i].gameObject.firstSprite, INT(enemies[i].gameObject.velx), INT(enemies[i].gameObject.vely));
                        }
                    }
                }
                if (player.invincibilityTimer == 0) //the player is not invincible
                {
                    if (checkCollision(&enemies[i].gameObject.collider, &player.gameObject.collider) && !player.deathTimer && !enemies[i].deathTimer)
                    {
                        player.deathTimer = explosionFrames + playerDeathHaltFrames;
                        flinger.dragShifts = detachedFlingerDragShifts;
                        flinger.attached = FALSE;
                    }
                }
                else //the player is invincible
                {
                    set_sprite_prop(player.gameObject.firstSprite, (player.invincibilityTimer >> 2) & 1 ? get_sprite_prop(player.gameObject.firstSprite) | S_PRIORITY : get_sprite_prop(player.gameObject.firstSprite) & ~S_PRIORITY); //used for blinking the player if invincible
                    player.invincibilityTimer--;
                }
            }
        }

        enemyUpdate++;
        if (enemyUpdate == 4)
        {
            enemyUpdate = 0;
        }

        enemyTimer--;
        if (enemyTimer == 0) //an enemy should be loaded this frame
        {
            int8_t index = loadEnemy();
            if (index != -1)
            {
                //TODO: this should be replaced by something
                enemies[index].accelerationShifts = 11;
                enemies[index].dragShifts = 4;
                enemies[index].gameObject.firstSprite = 2 + index;
                enemies[index].gameObject.spriteSizex = 1;
                enemies[index].gameObject.spriteSizey = 1;
                enemies[index].gameObject.posx = player.gameObject.posx;
                enemies[index].gameObject.posy = sub(player.gameObject.posy, FIXED(80));
                enemies[index].gameObject.velx = FIXED(0);
                enemies[index].gameObject.vely = FIXED(0);
                enemies[index].gameObject.collider.posx = enemies[index].gameObject.posx;
                enemies[index].gameObject.collider.posy = enemies[index].gameObject.posy;
                enemies[index].gameObject.collider.sizex = FIXED(8);
                enemies[index].gameObject.collider.sizey = FIXED(8);
                enemies[index].type = follower;
                enemies[index].deathTimer = 0;

                enemyTimer = resetEnemyTimer;
            }
            else
            {
                //if an enemy couldn't be loaded, delay the loading
                enemyTimer++;
            }
        }

        updateGameObject(&player.gameObject, &player.gameObject);

        showScore(score);
        showLives(lives);

        moveBackground(&player.gameObject);

        wait_vbl_done();
    } 
}