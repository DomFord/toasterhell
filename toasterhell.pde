/*
Toasterhell, final handin
Made by Dominic Francis Stephen Ford (dofo@itu.dk) and Frederik Boye Hansen (frbh@itu.dk)
ITU 2017, Programming for Designers
*/

LevelManager levelManager;
PlayerManager playerManager;
EnemyManager enemyManager;
Star[] stars;
int gamestate, ticksElapsed;

void setup() {
  size(800,600);
  background(0);
  gamestate = 1;
  ticksElapsed = 0;

  levelManager = new LevelManager();
  playerManager = new PlayerManager();
  enemyManager = new EnemyManager();

  stars = new Star[10];
  for (int i = 0; i < 10; i++) {
    stars[i] = new Star();
  }

}

void keyPressed() {
  /* switch for debugging */
  switch (key) {
    case '1':
      gamestate = 1;
      break;
    case '2':
      gamestate = 2;
      break;
    case '3':
      gamestate = 3;
      break;
    case '4':
      gamestate = 4;
      break;
  }

  switch (gamestate) {
    case 1:
      switch (keyCode) {
        case LEFT:
          playerManager.left = true;
          break;
        case RIGHT:
          playerManager.right = true;
          break;
        case UP:
          playerManager.up = true;
          break;
        case DOWN:
          playerManager.down = true;
          break;
      }
      switch (key) {
        case ' ':
          playerManager.shooting = true;
          break;
      }
      break;
  }
}

void keyReleased() {
  switch (gamestate) {
    case 1:
      switch (keyCode) {
        case LEFT:
          playerManager.left = false;
          break;
        case RIGHT:
          playerManager.right = false;
          break;
        case UP:
          playerManager.up = false;
          break;
        case DOWN:
          playerManager.down = false;
          break;
      }
      switch (key) {
        case ' ':
          playerManager.shooting = false;
          break;
      }
      break;
  }
}

void draw() {
levelManager.levelSelector();
playerManager.drawPlayer();
enemyManager.enemySpawner();
ticksElapsed++;

  switch (gamestate) {
    case 1 :
      break;
    case 2 :
      break;
    case 3 :
      break;
    case 4 :
      break;
  }
}
