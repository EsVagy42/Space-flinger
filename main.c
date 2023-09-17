#include <gb/gb.h>
#include "Gamefunctions.c"

Enemy* currentEnemy;
uint8_t enemyCount;

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
            currentEnemy = &enemies[0];
            enemyCount = 0;
            for (currentEnemyIndex = 0; currentEnemyIndex < MAX_ENEMY_NUMBER; currentEnemyIndex++)
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
                            deloadEnemy(currentEnemy, currentEnemyIndex);
                        }
                        else
                        {
                            playEnemyDeathAnimation(currentEnemy, currentEnemyIndex);
                        }
                    }

                    if (PLAYER_HIT_BY_CURRENT_ENEMY && !PLAYER_INVINCIBLE)
                    {
                        setupPlayerDeathAnimation();
                    }

                    enemyCount++;
                }

                currentEnemy++;
            }

            if (enemyCount == 0 && currentEnemyInWave == 8)
            {
                showTimeBonusText();
                loadNextWave();
            }

            if (PLAYER_INVINCIBLE)
            {
                blinkPlayerSprite();
            }

            updatePlayerInvincibilityTimer();

            updateEnemyUpdateCounter();

            frameCounter++;
            if (frameCounter >= 60)
            {
                frameCounter = 0;
                uint8_t subtract[] = {0, 1};
                subBCD(waveCountdown, subtract, 2);
                showTime(waveCountdown);
                if (WAVECOUNTDOWN_REACHED_0)
                {
                    loadNextWave();
                }
            }

            enemyLoadTimer--;
            if (enemyLoadTimer == 0)
            {
                enemyLoadTimer = currentWave->enemyLoadDelay;
                if (currentEnemyInWave < 8)
                {
                    loadNextEnemy();
                    currentEnemyInWave++;
                }
            }

            // enemyTimer--;
            // if (enemyTimer == 0) //an enemy should be loaded this frame
            // {
            //     loadEnemy();
            // }

            updateGameObject(&player.gameObject, &player.gameObject);

            if (messageTimer != 0)
            {
                messageTimer--;
                if (messageTimer == 0)
                {
                    showEmptyText();
                }
            }

            moveBackground(&player.gameObject);
        }

        wait_vbl_done();
    } 
}