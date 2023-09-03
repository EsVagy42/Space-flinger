#include <gb/gb.h>
#include "Gamefunctions.c"

void main()
{
    setup();

    //game loop
    while(1)
    {
        updateInput();

        switch (paused)
        {
            case TRUE:
                if (START_BUTTON_PRESSED)
                {
                    unPauseGame();
                    paused = FALSE;
                }
                break;
            
            case FALSE:
                if (START_BUTTON_PRESSED)
                {
                    pauseGame();
                    paused = TRUE;
                }
        }

        if (!paused)
        {
            if (PLAYER_ALIVE)
            {
                updatePlayer();
            }
            else
            {
                playPlayerDeathAnimation();
            }

            if (flinger.attached)
            {
                updateAttachedFlinger();
            }
            else
            {
                updateDetachedFlinger();
            }

            //updating the enemies
            Enemy* currentEnemy = &enemies[0];
            for (uint8_t i = 0; i < MAX_ENEMY_NUMBER; i++)
            {
                if (CURRENTENEMY_ACTIVE)
                {
                    if (CURRENTENEMY_ALIVE)
                    {
                        if (CURRENTENEMY_HIT)
                        {
                            setupEnemyDeathAnimation(currentEnemy);
                        }
                        else
                        {
                            if (ENEMY_UPDATES_IN_CURRENT_FRAME)
                            {
                                updateEnemy(currentEnemy);
                            }
                            updateGameObject(&currentEnemy->gameObject, &player.gameObject);
                        }
                    }
                    else //enemy death animation playing
                    {
                        currentEnemy->deathTimer--;
                        if (currentEnemy->deathTimer == 0)
                        {
                            deloadEnemy(currentEnemy, i);
                        }
                        else
                        {
                            playEnemyDeathAnimation(currentEnemy);
                        }
                    }

                    if (PLAYER_HIT_BY_CURRENT_ENEMY && !PLAYER_INVINCIBLE)
                    {
                        setupPlayerDeathAnimation();
                    }
                }

                currentEnemy++;
            }

            if (PLAYER_INVINCIBLE)
            {
                blinkPlayerSprite();
            }

            updatePlayerInvincibilityTimer();

            updateEnemyUpdateCounter();

            enemyTimer--;
            if (enemyTimer == 0) //an enemy should be loaded this frame
            {
                loadEnemy();
            }

            updateGameObject(&player.gameObject, &player.gameObject);

            showScore(score);
            showLives(lives);

            moveBackground(&player.gameObject);
        }

        wait_vbl_done();
    } 
}