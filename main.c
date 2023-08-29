#include <gb/gb.h>
#include "Additionalfunctions.c"
#include "Assets/Spaceships.c"  //sprite tiles
#include "Assets/Space.c" //background tiles
#include "Assets/SpaceMap.c" //background map

uint8_t enemyUpdate = 0; //used for checking if an enemy needs to be updated in the current frame. Enemies are updated every 4th frame to save on cpu usage

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
    initPlayer(&player);

    //initializing the flinger
    Flinger flinger;
    initFlinger(&flinger);

    //game loop
    while(1)
    {
        fixed16 x;
        fixed16 y;
        if (player.deathTimer == 0) //that means the player is alive
        {
            uint8_t input = joypad();
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
                            enemies[i].move(&enemies[i], &player);
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