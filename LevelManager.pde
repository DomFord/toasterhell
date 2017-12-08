/*
This script deals with levels; it handles what level is selected and how each level plays out etc.
*/
class LevelManager{
  color bgColour;
  int backgroundyPos;
  PImage backgroundGrass;
  PImage backgroundWater;
  PImage backgroundRock;
  PImage backgroundIce;
  PImage backgroundLava;

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
  }

  void levelSelector() {
    switch (gamestate) {
      case 1:
        image(backgroundGrass,width/2,backgroundyPos);
        image(backgroundGrass,width/2,(backgroundyPos-backgroundGrass.height));
        backgroundyPos++;
        if(backgroundyPos >= backgroundGrass.height){
          backgroundyPos = 0;
        }
        spaceLevel();
      break;
      case 2:
        image(backgroundWater,width/2,backgroundyPos);
        image(backgroundWater,width/2,(backgroundyPos-backgroundWater.height));
        backgroundyPos++;
        if(backgroundyPos >= backgroundWater.height){
          backgroundyPos = 0;
        }
        spaceLevel();
      break;
      case 3:
        image(backgroundRock,width/2,backgroundyPos);
        image(backgroundRock,width/2,(backgroundyPos-backgroundRock.height));
        backgroundyPos++;
        if(backgroundyPos >= backgroundRock.height){
          backgroundyPos = 0;
        }
        spaceLevel();
      break;
      case 4:
        image(backgroundIce,width/2,backgroundyPos);
        image(backgroundIce,width/2,(backgroundyPos-backgroundIce.height));
        backgroundyPos++;
        if(backgroundyPos >= backgroundIce.height){
          backgroundyPos = 0;
        }
        spaceLevel();
      break;
      case 5:
        image(backgroundLava,width/2,backgroundyPos);
        image(backgroundLava,width/2,(backgroundyPos-backgroundLava.height));
        backgroundyPos++;
        if(backgroundyPos >= backgroundLava.height){
          backgroundyPos = 0;
        }
        spaceLevel();
      break;
    }
  }

  void spaceLevel() {
    for (int i = 0; i < stars.length; i++) {
      stars[i].moveStar();
    }
  }
}
