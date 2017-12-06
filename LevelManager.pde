/*
This script deals with levels; it handles what level is selected and how each level plays out etc.
*/
class LevelManager{
  color bgColour;

  LevelManager() {
  }

  void levelSelector() {
    switch (gamestate) {
      case 1:
        bgColour = color(12, 23, 45);
        spaceLevel();
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
    }
  }

  void spaceLevel() {
    background(bgColour);
    for (int i = 0; i < stars.length; i++) {
      stars[i].moveStar();
    }
  }
}
