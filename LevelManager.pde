/*
This script deals with levels; it handles what level is selected and how each level plays out etc.
*/
class LevelManager{
  color bgColour;
  int backgroundyPos;
  PImage backgroundGrass, backgroundWater, backgroundRock, backgroundIce, backgroundLava, endlessLevelBackground;
  PImage[] backgrounds;

  LevelManager() {
    backgroundyPos = 0;
    backgroundGrass = loadImage("grass.png");
    backgroundWater = loadImage("water.png");
    backgroundRock = loadImage("rocks.png");
    backgroundIce = loadImage("ice.png");
    backgroundLava = loadImage("lava.png");
    backgroundGrass.resize(width,0);
    backgroundWater.resize(width,0);
    backgroundRock.resize(width,0);
    backgroundIce.resize(width,0);
    backgroundLava.resize(width,0);
    backgrounds = new PImage[6];
      backgrounds[0] = backgroundGrass;
      backgrounds[1] = backgroundWater;
      backgrounds[2] = backgroundRock;
      backgrounds[3] = backgroundIce;
      backgrounds[4] = backgroundLava;
      backgrounds[5] = backgroundGrass;
  }

  void levelSelector() {
      drawBackground(backgrounds[gamestate - 1]);
  }

  void drawBackground(PImage level) {
    image(level, width / 2, backgroundyPos);
    image(level, width / 2, (backgroundyPos-level.height));
    backgroundyPos++;
    if(backgroundyPos >= level.height){
      backgroundyPos = 0;
    }
    starParticles();
  }

  void starParticles() {
    for (int i = 0; i < stars.length; i++) {
      stars[i].moveStar();
    }
  }
}
