#include <gb/gb.h>
#include "Additionalfunctions.c"
#include "Assets/Spaceships.c"  //sprite tiles
#include "Assets/Space.c" //background tiles
#include "Assets/SpaceMap.c" //background map

#define START_BUTTON_PRESSED (input & J_START && !(lastInput && J_START))
#define PLAYER_ALIVE (player.deathTimer == 0)
#define CURRENTENEMY_ACTIVE (activeEnemies[i])
#define CURRENTENEMY_ALIVE (currentEnemy->deathTimer == 0)
#define CURRENTENEMY_HIT (checkCollision(&currentEnemy->gameObject.collider, &flinger.gameObject.collider))
#define ENEMY_UPDATES_IN_CURRENT_FRAME (i == enemyUpdate || i == enemyUpdate + (MAX_ENEMY_NUMBER >> 1))
#define PLAYER_INVINCIBLE (player.invincibilityTimer != 0)
#define PLAYER_HIT_BY_CURRENT_ENEMY (checkCollision(&currentEnemy->gameObject.collider, &player.gameObject.collider) && !player.deathTimer && !currentEnemy->deathTimer)

uint8_t enemyUpdate = 0; //used for checking if an enemy needs to be updated in the current frame. Enemies are updated every 4th frame to save on cpu usage

//scores and lives are held in Binary Coded Decimal. every digit gets stored in an uint8_t value
uint8_t score[6] = {0, 0, 0, 0, 0, 0};
uint8_t lives[2] = {0, 5};

uint8_t enemyTimer = 1; //if it reaches 0, an enemy is loaded and is reset to resetEnemyTimer
uint8_t resetEnemyTimer = 255;

Player player;
Flinger flinger;

uint8_t input = 0;
uint8_t lastInput = 0;

BOOLEAN paused = FALSE;

fixed16 x;
fixed16 y;


void setup()
{
    SHOW_SPRITES;
    SHOW_BKG;
    SHOW_WIN;

    move_win(0, 136); //for the HUD

    OBP0_REG = 0x1B; //for setting the sprite palette

    set_sprite_data(0, 128, SpaceShipTiles);

    set_sprite_tile(0, 0); //player

    set_sprite_tile(1, 3); //flinger

    set_bkg_data(0, 128, SpaceTiles);

    set_bkg_tiles(0, 0, 32, 32, SpaceMap);

    //initializing the player
    initPlayer(&player);

    //initializing the flinger
    initFlinger(&flinger);
}

inline void updateInput()
{
    lastInput = input;
    input = joypad();
}

inline void pauseGame()
{
    HIDE_SPRITES;
}

inline void unPauseGame()
{
    SHOW_SPRITES;
}

inline void updatePlayer()
{
    if (input & J_A) //A is pressed
    {
        flinger.attached = FALSE;
        flinger.dragShifts = DETACHED_FLINGER_DRAG_SHIFTS;
    }
    getInput(input, &x, &y);
    accelerateGameObject(&player.gameObject, x, y);
    applyDragToGameObject(&player.gameObject, player.dragShifts);
    setRotatedSprite(0, 0, x, y);
}

inline void playPlayerDeathAnimation()
{
    if (player.deathTimer > PLAYER_DEATH_HALT_FRAMES) //the death animation is playing
    {
        set_sprite_tile(player.gameObject.firstSprite,
            (EXPLOSION_ANIMATION_FRAMES - ((player.deathTimer - PLAYER_DEATH_HALT_FRAMES) >> 2)) + EXPLOSION_OFFSET);
        applyDragToGameObject(&player.gameObject, player.dragShifts);
    }
    player.deathTimer--;
    if (player.deathTimer == 0)
    {
        set_sprite_tile(player.gameObject.firstSprite, 0);
        uint8_t subLives[] = {0, 1};
        subBCD(lives, subLives, 2);
        player.invincibilityTimer = INVINCIBILITY_FRAMES;
    }
    applyDragToGameObject(&player.gameObject, player.dragShifts);
}

inline void updateAttachedFlinger()
{
    x = sub(player.gameObject.posx, flinger.gameObject.posx);
    y = sub(player.gameObject.posy, flinger.gameObject.posy);
    if (abs(x) + abs(y) < FLINGER_DISTANCE) //flinger is repelled because it is too close to the player
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
    applyDragToGameObject(&flinger.gameObject, flinger.dragShifts);
    updateGameObject(&flinger.gameObject, &player.gameObject);
}

inline void updateDetachedFlinger()
{
    if (checkCollision(&player.gameObject.collider, &flinger.gameObject.collider))
    {
        flinger.attached = TRUE;
        flinger.dragShifts = ATTACHED_FLINGER_DRAG_SHIFTS;
    }
    applyDragToGameObject(&flinger.gameObject, flinger.dragShifts);
    updateGameObject(&flinger.gameObject, &player.gameObject);
}

inline void setupEnemyDeathAnimation(Enemy* currentEnemy)
{
    currentEnemy->deathTimer = TOTAL_ANIMATION_FRAMES;
    currentEnemy->gameObject.spriteSizex = 1;
    currentEnemy->gameObject.spriteSizey = 1;
    currentEnemy->points = SpaceshipPoints[currentEnemy->type] + (flinger.attached ? 0 : 1);
    set_sprite_prop(currentEnemy->gameObject.firstSprite, 0);
    set_sprite_tile(currentEnemy->gameObject.firstSprite, EXPLOSION_OFFSET);
    currentEnemy->gameObject.velx = flinger.gameObject.velx;
    currentEnemy->gameObject.vely = flinger.gameObject.vely;
    updateGameObject(&currentEnemy->gameObject, &player.gameObject);
}

inline void updateEnemy(Enemy* currentEnemy)
{
    currentEnemy->move(currentEnemy, &player);
    currentEnemy->updateSprites(currentEnemy);
}

inline void playEnemyDeathAnimation(Enemy* currentEnemy)
{
    if (currentEnemy->deathTimer == POINT_FRAMES) //the score for the enemy should begin showing this frame
    {
        addScore(score, currentEnemy->points);
        set_sprite_tile(currentEnemy->gameObject.firstSprite, POINT_OFFSET + currentEnemy->points);
    }
    else if (currentEnemy->deathTimer < POINT_FRAMES) //the score for the enemy is being displayed
    {
        scroll_sprite(currentEnemy->gameObject.firstSprite, 0, -1);
    }
    else //the death animation is showing
    {
        set_sprite_tile(currentEnemy->gameObject.firstSprite,
        (EXPLOSION_ANIMATION_FRAMES - ((currentEnemy->deathTimer - POINT_FRAMES) >> 2)) + EXPLOSION_OFFSET);
        applyDragToGameObject(&currentEnemy->gameObject, currentEnemy->dragShifts);
        scroll_sprite(currentEnemy->gameObject.firstSprite, INT(currentEnemy->gameObject.velx), INT(currentEnemy->gameObject.vely));
    }
}

inline void setupPlayerDeathAnimation()
{
    player.deathTimer = EXPLOSION_FRAMES + PLAYER_DEATH_HALT_FRAMES;
    flinger.dragShifts = DETACHED_FLINGER_DRAG_SHIFTS;
    flinger.attached = FALSE;
}

inline void blinkPlayerSprite()
{
    set_sprite_prop(player.gameObject.firstSprite, (player.invincibilityTimer >> 2) & 1 ? get_sprite_prop(player.gameObject.firstSprite) | S_PRIORITY : get_sprite_prop(player.gameObject.firstSprite) & ~S_PRIORITY);
}

inline void updatePlayerInvincibilityTimer()
{
    if (player.invincibilityTimer != 0)
    {
        player.invincibilityTimer--;
    }
}

inline void updateEnemyUpdateCounter()
{
    enemyUpdate++;
    if (enemyUpdate == 4)
    {
        enemyUpdate = 0;
    }
}

inline void loadEnemy()
{
    int8_t index = getAvailableEnemySpot();
    if (index != -1)
    {
        initFollower(index, &player);

        enemyTimer = resetEnemyTimer;
    }
    else
    {
        //if an enemy couldn't be loaded, delay the loading
        enemyTimer++;
    }
}

inline void deloadEnemy(Enemy* currentEnemy, uint8_t i)
{
    activeEnemies[i] = FALSE;
    hide_sprite(currentEnemy->gameObject.firstSprite);
}