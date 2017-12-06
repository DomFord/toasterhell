/*
This script deals with levels; it handles what level is selected and how each level plays out etc.
*/
class LevelManager{

  LevelManager() {
  }

  void levelSelector() {
    switch (gamestate) {
      case 1:
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
    for (int i = 0; i < stars.length; i++) {
      stars[i].moveStar();
    }
  }
}
