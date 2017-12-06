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
}

void draw() {
background(0);
levelManager.levelSelector();

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
