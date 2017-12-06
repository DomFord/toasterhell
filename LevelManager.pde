/*
This script deals with levels; it handles what level is selected and how each level plays out etc.
*/
class LevelManager{

  void spaceLevel() {
    for (int i = 0; i < stars.length; i++) {
      stars[i].moveStar();
    }
  }
}
