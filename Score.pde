/*
Author: Frederik Boye
Homepage: http://www.frederikboye.com
"If you're not weird, don't expect me to understand you"
*/
class Score{
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
