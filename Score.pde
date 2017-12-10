class Score{ //simple score object for the highscore array lists
  int points;
  String tag;

  @Override
  String toString(){
     return tag + ":" + points;
  }

  int getPoints(){
    return points;
  }
}
