#define MAX_ENEMY_NUMBER 8 //number of enemies allowed

#define FLINGER_DISTANCE FIXED(13) //if the flinger gets closer to the spaceship than this, it will be repelled
#define FLINGER_INACTIVE_SPEED FIXED(.125)//if the flinger slows below this speed, it becomes inactive

#define EXPLOSION_FRAMES 20 //for animation
#define POINT_FRAMES 30  //for animation
#define TOTAL_ANIMATION_FRAMES (EXPLOSION_FRAMES + POINT_FRAMES) //total number of animated frames when an enemy explodes
#define PLAYER_DEATH_HALT_FRAMES 120 //after the player dying the game will halt for that many frames 
#define POINT_OFFSET 121 //from which tile number the point tiles begin
#define NUMBERS_OFFSET 118 //from which tile number the number tiles begin
#define EXPLOSION_OFFSET 7 //from which tile number the explosion tiles begin
#define EXPLOSION_ANIMATION_FRAMES 5 //how many frames of animation the explosion effect uses

#define INVINCIBILITY_FRAMES 120 //after death the player is invincible for that many frames

#define INPUT_SPEED FIXED(.3) //this number is output by the getInput function for x or y
#define INPUT_SPEED_DIAGONAL FIXED(.2121) //this number is output by the getInput function for x or y if more than one direction is pressed

#define ATTACHED_FLINGER_DRAG_SHIFTS 5
#define DETACHED_FLINGER_DRAG_SHIFTS 6

#define UNPAUSE_TIMER_START 30
#define UNPAUSE_COUNTER_SHIFTS 2

const uint8_t lookup[7][8] = {
    {0, 0, 0, 0, 1, 0},
    {0, 0, 0, 0, 2, 5},
    {0, 0, 0, 0, 5, 0},
    {0, 0, 0, 1, 0, 0},
    {0, 0, 0, 2, 5 ,0},
    {0 ,0 ,0 ,5 ,0 ,0},
    {0 ,0 ,1 ,0 ,0 ,0}
};

const uint8_t pauseText[] = {0, 0, 0, 0, 0, 0, 0, 19, 4, 24, 22, 8, 7, 0, 0, 0, 0, 0, 0, 0};
const uint8_t empty[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
const uint8_t timeText[] = {0, 0, 0, 23, 12, 16, 8, 0, 5, 18, 17, 24, 22, 0, 0, 0, 0, 0, 0, 0};