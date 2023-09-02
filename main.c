#include <gb/gb.h>
#include "Enemies.c"
#include "Assets/Spaceships.h"  //sprite tiles
#include "Assets/Space.h" //background tiles
#include "Assets/SpaceMap.h" //background map

uint8_t enemyUpdate = 0; //used for checking if an enemy needs to be updated in the current frame. Enemies are updated every 4th frame to save on cpu usage

//scores and lives are held in Binary Coded Decimal. every digit gets stored in an uint8_t value
uint8_t score[6] = {0, 0, 0, 0, 0, 0};
uint8_t lives[2] = {0, 3};

uint8_t enemyTimer = 1; //if it reaches 0, an enemy is loaded and is reset to resetEnemyTimer
uint8_t resetEnemyTimer = 255;

Player player;
Flinger flinger;

uint8_t input = 0;
uint8_t lastInput = 0;

uint8_t unpauseTimer = 0; //when something other than 0, the game is paused
uint8_t unpauseCounter = 0;
//when the game is paused, unpauseTimer is 255. When it is unpaused, it sets to 1 and unpauseCounter sets to unpauseTimer.
//unpauseCounter counts down every frame. When it reaches 0, the game stops for a frame and unpauseTimer gets increased, and unpauseCounter sets to unpauseTimer once again.
//when unpauseTimer reaches unpauseTimerStart, it sets unpauseTimer to 0 and the game continues running

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

void main()
{
    setup();

    //game loop
    while(1)
    {
        lastInput = input;
        input = joypad();


        if (input & J_START && !(lastInput & J_START)) //start button pressed
        {
            if (unpauseTimer == 0)
            {
                HIDE_SPRITES;
                unpauseTimer = 255;
            }
            else if (unpauseTimer == 255)
            {
                SHOW_SPRITES;
                unpauseTimer = 1;
                unpauseCounter = unpauseTimer;
            }
        }

        if (unpauseTimer != 0)
        {
            if (unpauseTimer != 255)
            {
                unpauseCounter--;
                if (unpauseCounter == 0)
                {
                    unpauseTimer++;
                    if (unpauseTimer == unpauseTimerStart)
                    {
                        unpauseTimer = 0;
                    }
                    unpauseCounter = (unpauseTimer >> unpauseCounterShifts) + 1;

                    wait_vbl_done();
                    continue; //skip game loop
                }
            }
            else
            {
                wait_vbl_done();
                continue; //skip game loop
            }
        }


        if (player.deathTimer == 0) //that means the player is alive
        {
            if (input & J_A) //A is pressed
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
            if (player.deathTimer == 0)
            {
                set_sprite_tile(player.gameObject.firstSprite, 0);
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
                Enemy* currentEnemy = &enemies[i];
                if (currentEnemy->deathTimer == 0) //the enemy is alive
                {
                    if (checkCollision(&currentEnemy->gameObject.collider, &flinger.gameObject.collider))
                    {
                        currentEnemy->deathTimer = totalAnimationFrames;
                        currentEnemy->gameObject.spriteSizex = 1;
                        currentEnemy->gameObject.spriteSizey = 1;
                        currentEnemy->points = SpaceshipPoints[currentEnemy->type] + (flinger.attached ? 0 : 1);
                        set_sprite_prop(currentEnemy->gameObject.firstSprite, 0);
                        set_sprite_tile(currentEnemy->gameObject.firstSprite, explosionOffset);
                        currentEnemy->gameObject.velx = flinger.gameObject.velx;
                        currentEnemy->gameObject.vely = flinger.gameObject.vely;
                        updateGameObject(&currentEnemy->gameObject, &player.gameObject);
                    }
                    else
                    {
                        if (i == enemyUpdate || i == enemyUpdate + (maxEnemyNumber >> 1)) //the enemy should be updated in the current frame
                        {
                            currentEnemy->move(currentEnemy, &player);
                            currentEnemy->updateSprites(currentEnemy);
                        }
                        updateGameObject(&currentEnemy->gameObject, &player.gameObject);
                    }
                }
                else //enemy death animation showing
                {
                    currentEnemy->deathTimer--;
                    if (!currentEnemy->deathTimer)
                    {
                        activeEnemies[i] = FALSE;
                        hide_sprite(currentEnemy->gameObject.firstSprite);
                    }
                    else
                    {
                        if (currentEnemy->deathTimer == pointFrames) //the score for the enemy should begin showing this frame
                        {
                            addScore(score, currentEnemy->points);
                            set_sprite_tile(currentEnemy->gameObject.firstSprite, pointOffset + currentEnemy->points);
                        }
                        else if (currentEnemy->deathTimer < pointFrames) //the score for the enemy is being displayed
                        {
                            scroll_sprite(currentEnemy->gameObject.firstSprite, 0, -1);
                        }
                        else //the death animation is showing
                        {
                            set_sprite_tile(currentEnemy->gameObject.firstSprite,
                            (explosionAnimationFrames - ((currentEnemy->deathTimer - pointFrames) >> 2)) + explosionOffset);
                            applyDragToGameObject(&currentEnemy->gameObject, currentEnemy->dragShifts);
                            scroll_sprite(currentEnemy->gameObject.firstSprite, INT(currentEnemy->gameObject.velx), INT(currentEnemy->gameObject.vely));
                        }
                    }
                }
                if (player.invincibilityTimer == 0) //the player is not invincible
                {
                    if (checkCollision(&currentEnemy->gameObject.collider, &player.gameObject.collider) && !player.deathTimer && !currentEnemy->deathTimer)
                    {
                        player.deathTimer = explosionFrames + playerDeathHaltFrames;
                        flinger.dragShifts = detachedFlingerDragShifts;
                        flinger.attached = FALSE;
                    }
                }
                else //the player is invincible
                {
                    set_sprite_prop(player.gameObject.firstSprite, (player.invincibilityTimer >> 2) & 1 ? get_sprite_prop(player.gameObject.firstSprite) | S_PRIORITY : get_sprite_prop(player.gameObject.firstSprite) & ~S_PRIORITY); //used for blinking the player if invincible
                }
            }
        }

        if (player.invincibilityTimer != 0)
        {
            player.invincibilityTimer--;
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
                initFollower(index, &player);

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