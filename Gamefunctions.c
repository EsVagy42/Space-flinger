#include <gb/gb.h>
#include "Additionalfunctions.c"
#include "Assets/Spaceships.c"  //sprite tiles
#include "Assets/Space.c" //background tiles
#include "Assets/SpaceMap.c" //background map

#define START_BUTTON_PRESSED (input & J_START & ~(lastInput & J_START))
#define PLAYER_ALIVE (player.deathTimer == 0)
#define CURRENTENEMY_ACTIVE (activeEnemies[currentEnemyIndex])
#define CURRENTENEMY_ALIVE (currentEnemy->deathTimer == 0)
#define CURRENTENEMY_HIT (checkCollision(&currentEnemy->gameObject.collider, &flinger.gameObject.collider) && flinger.active)
#define ENEMY_UPDATES_IN_CURRENT_FRAME (currentEnemyIndex == enemyUpdate || currentEnemyIndex == enemyUpdate + (MAX_ENEMY_NUMBER >> 1))
#define PLAYER_INVINCIBLE (player.invincibilityTimer != 0)
#define PLAYER_HIT_BY_CURRENT_ENEMY (checkCollision(&currentEnemy->gameObject.collider, &player.gameObject.collider) && !player.deathTimer && !currentEnemy->deathTimer)
#define WAVECOUNTDOWN_REACHED_0 (waveCountdown[0] == 0 && waveCountdown[1] == 0)

int8_t enemyUpdate = 0; //used for checking if an enemy needs to be updated in the current frame. Enemies are updated every 4th frame to save on cpu usage

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

uint8_t frameCounter = 0; //counts up to 60. used for decreasing the wave timer every second
uint8_t waveCountdown[2]; //wave timer
uint8_t enemyLoadTimer;
uint8_t currentEnemyInWave = 0;

uint8_t currentWaveBCD[] = {0, 0};
Wave* currentWave;

uint8_t messageTimer = 0; //gets decreased every frame. one it hits 0, the current message gets cleared from the screen

int8_t currentEnemyIndex = 0;

fixed16 x;
fixed16 y;

inline void increaseCurrentWave()
{
    uint8_t increaseWave[] = {0, 1};
    addBCD(currentWaveBCD, increaseWave, 2);
    showWave(currentWaveBCD);
    currentWave++;
}

inline void deloadEnemy(Enemy* currentEnemy, uint8_t i)
{
    activeEnemies[i] = FALSE;
    hide_sprite(currentEnemy->gameObject.firstSprite);
}

inline void loadWaveEnemy(uint8_t index)
{
    spaceShipFunctions[currentWave->initFunctions[index]](index, &player);
}

inline void loadNextEnemy()
{
    activeEnemies[currentEnemyInWave] = TRUE;
}

uint8_t deloadEnemyIndex;
inline void loadNextWave()
{
    increaseCurrentWave();
    copyBCD(waveCountdown, currentWave->waveCountdown, 2);
    enemyLoadTimer = currentWave->enemyLoadDelay;
    currentEnemyInWave = 0;
    for (deloadEnemyIndex = 0; deloadEnemyIndex < MAX_ENEMY_NUMBER; deloadEnemyIndex++)
    {
        deloadEnemy(&enemies[deloadEnemyIndex], deloadEnemyIndex);
        loadWaveEnemy(deloadEnemyIndex);
        set_sprite_tile(deloadEnemyIndex + ENEMY_DISPLAY_STARTING_SPRITE, enemies[deloadEnemyIndex].enemyDisplayTile);
        set_sprite_prop(deloadEnemyIndex + ENEMY_DISPLAY_STARTING_SPRITE, 0);
    }
}

void interrupt()
{
    switch (LYC_REG)
    {    
        case 7:
            if (!paused)
            {
                SHOW_SPRITES;
            }
            HIDE_WIN;
            LYC_REG = 135;
            break;

        case 135:
            if (messageTimer != 0)
            {
                HIDE_SPRITES;
            }
            SHOW_WIN;
            LYC_REG = 7;
            break;
    }
}

void setup()
{
    SHOW_SPRITES;
    SHOW_BKG;
    SHOW_WIN;

    move_win(7, 0); //for the HUD

    OBP0_REG = 0x1B; //for setting the sprite palette
    OBP1_REG = 0x6F; //for setting the inactive sprite palette

    set_sprite_data(0, 128, SpaceShipTiles);

    set_sprite_tile(0, 0); //player

    set_sprite_tile(1, 3); //flinger

    set_bkg_data(0, 128, SpaceTiles);

    set_bkg_tiles(0, 0, 32, 32, SpaceMap);

    STAT_REG |= STATF_LYC;
    LYC_REG = 135;
    CRITICAL
    {
        add_LCD(interrupt);
    }
    set_interrupts(LCD_IFLAG | VBL_IFLAG);

    uint8_t xPos = ENEMY_DISPLAY_FIRST_SPRITE_POS_X;
    for (uint8_t i = ENEMY_DISPLAY_STARTING_SPRITE; i < ENEMY_DISPLAY_STARTING_SPRITE + MAX_ENEMY_NUMBER; i++)
    {
        move_sprite(i, xPos, ENEMY_DISPLAY_SPRITES_POS_Y);
        xPos += 10;
    }

    currentWave = waves - 1;
    loadNextWave();

    //initializing the player
    initPlayer(&player);

    //initializing the flinger
    initFlinger(&flinger);


    showScore(score);
    showLives(lives);
    showWave(currentWaveBCD);
    showTime(waveCountdown);
}

inline void showPauseText()
{
    set_win_tiles(0, 1, 20, 1, pauseText);
}

inline void showEmptyText()
{
    set_win_tiles(0, 1, 20, 1, empty);
}

inline void showTimeBonusText()
{
    uint8_t bonus[6] = {0, 0, 0, 0, waveCountdown[0], waveCountdown[1]};
    addBCD(score, bonus, 6);
    showScore(score);
    set_win_tiles(0, 1, 15, 1, timeText);
    set_win_tile_xy(15, 1, waveCountdown[0] + NUMBERS_OFFSET);
    set_win_tile_xy(16, 1, waveCountdown[1] + NUMBERS_OFFSET);
    set_win_tiles(17, 1, 3, 1, timeText);
    messageTimer = 120;
}

inline void updateInput()
{
    lastInput = input;
    input = joypad();
}

inline void pauseGame()
{
    HIDE_SPRITES;
    showPauseText();
    
}

inline void unPauseGame()
{
    SHOW_SPRITES;
    showEmptyText();
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
        showLives(lives);
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
        flinger.active = TRUE;
        set_sprite_prop(flinger.gameObject.firstSprite, 0);
    }
    else if (abs(flinger.gameObject.velx) < FLINGER_INACTIVE_SPEED && abs(flinger.gameObject.vely) < FLINGER_INACTIVE_SPEED)
    {
        flinger.active = FALSE;
        set_sprite_prop(flinger.gameObject.firstSprite, S_PALETTE);
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
    currentEnemy->gameObject.velx = flinger.gameObject.velx >> 2;
    currentEnemy->gameObject.vely = flinger.gameObject.vely >> 2;
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
        showScore(score);
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