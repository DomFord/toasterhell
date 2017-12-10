/*
This script deals with levels; it handles what level is selected and how each level plays out etc.
*/
class LevelManager{
  color bgColour;
  int backgroundyPos, a, switchScreenX, switchScreenX2;
  PImage backgroundGrass, backgroundWater, backgroundRock, backgroundIce, backgroundLava, backgroundCrystal;
  PImage[] backgrounds;

  LevelManager() {
    backgroundyPos = 0;
    a = 0;
    backgroundGrass = loadImage("grass.png");
    backgroundWater = loadImage("water.png");
    backgroundRock = loadImage("rocks.png");
    backgroundIce = loadImage("ice.png");
    backgroundLava = loadImage("lava.png");
    backgroundCrystal = loadImage("crystal.png");
    backgroundGrass.resize(width,0);
    backgroundWater.resize(width,0);
    backgroundRock.resize(width,0);
    backgroundIce.resize(width,0);
    backgroundLava.resize(width,0);
    backgroundCrystal.resize(width,0);
    backgrounds = new PImage[6];
      backgrounds[0] = backgroundGrass;
      backgrounds[1] = backgroundWater;
      backgrounds[2] = backgroundRock;
      backgrounds[3] = backgroundIce;
      backgrounds[4] = backgroundLava;
      backgrounds[5] = backgroundCrystal;
  }

  void levelSelector() { //handles the advance in levels from 1-6 and checks your highscore at the end
      switch (menuIndex) {
      case 3:
        drawBackground(backgrounds[gamestate - 1]);
      break;
      case 4:
        if(gamestate <= 4){
          advanceGamestate();
          enemyManager.enemyCounter = 0;
        }
        else{
          if(playerManager.score > highScoreList.get(9).points){  //checks if the player has set a new highscore better than the lowest one currently on the list
            menuIndex = 5;
          }
          else{
            menuIndex = 6;
          }
        }
      break;
    }
  }

  void drawBackground(PImage level) { //draws a continuously scrolling background
    image(level, width / 2, backgroundyPos);
    image(level, width / 2, (backgroundyPos-level.height));
    backgroundyPos++;
    if(backgroundyPos >= level.height){
      backgroundyPos = 0;
    }
    starParticles();
  }

  void advanceGamestate() { //shows a fancy animation between levels
    int nextLevel = gamestate + 1;
    background(0, 0, 0, a);
    textFont(font, 50);
    fill (255, 255, 255, a);
    textAlign(CENTER, CENTER);
    text("LEVEL " + nextLevel, switchScreenX, height / 2);
    textAlign(CENTER, CENTER);
    if (millis() / 1000 % 2 == 0) {
      text("press SPACE to continue", width / 2, height - 200);
    }
    if (a < 255) {
      a++;
    }
    if (switchScreenX < width / 2) {
      switchScreenX += 5;
    }
    if (switchScreenX2 > width / 2) {
      switchScreenX2 += 10;
    }
  }

  void starParticles() { //shows little particles to emulate wind and a feeling of flying forwards
    for (int i = 0; i < stars.length; i++) {
      stars[i].moveStar();
    }
  }
}
