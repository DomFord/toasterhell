/*
Toasterhell, final handin
Made by Dominic Francis Stephen Ford (dofo@itu.dk) and Frederik Boye Hansen (frbh@itu.dk)
ITU 2017, Programming for Designers
*/

LevelManager levelManager;
PlayerManager playerManager;
Star[] stars;
int gamestate;

void setup() {
  size(800,600);
  background(0);
  gamestate = 1;

  levelManager = new LevelManager();
  playerManager = new PlayerManager();

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
          //playerManager.movePlayer(0);
          playerManager.left = true;
          break;
        case RIGHT:
          //playerManager.movePlayer(1);
          playerManager.right = true;
          break;
        case UP:
          //playerManager.movePlayer(2);
          playerManager.up = true;
          break;
        case DOWN:
          //playerManager.movePlayer(3);
          playerManager.down = true;
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
          //playerManager.movePlayer(0);
          playerManager.left = false;
          break;
        case RIGHT:
          //playerManager.movePlayer(1);
          playerManager.right = false;
          break;
        case UP:
          //playerManager.movePlayer(2);
          playerManager.up = false;
          break;
        case DOWN:
          //playerManager.movePlayer(3);
          playerManager.down = false;
          break;
      }
      break;
  }
}

void draw() {
levelManager.levelSelector();
playerManager.drawPlayer();

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
