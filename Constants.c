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