/*
Author: Frederik Boye
Homepage: http://www.frederikboye.com
"If you're not weird, don't expect me to understand you"
*/
class LeaderboardsInput{
  String name;
  int letter1;
  int letter2;
  int letter3;
  int curserPos;
  int letterSelect;
  String[] nameconstructor = { "A", "A", "A"};
  String[] alphabet = { "A", "B", "C", "D", "E", "F", "G", "H", "I",
                        "J", "K", "L", "M", "N", "O", "P", "Q", "R",
                        "S", "T", "U", "V", "W", "X", "Y", "Z", "1",
                        "2", "3", "4", "5", "6", "7", "8", "9", "0"};

  LeaderboardsInput(){
    letterSelect = 0;
    curserPos = 0;
  }


  void showBoard(){
    name = join(nameconstructor, "");
  }

  void saveScore(){
    scores.add(new Score(name, playerManager.score));
    FileManager.saveScore("memes.dat", scores);
    gamestate = 7;
  }

  void displayInput(){
    fill(255);
    textFont(font,(150));
    textAlign(CENTER);
    text(nameconstructor[0], 149, 340);
    text(nameconstructor[1], 249, 340);
    text(nameconstructor[2], 349, 340);
    textFont(font,(15));
    text("USE ARROW KEYS TO SET TAG", 240, 480);
    text("PRESS SPACE TO CONFIRM", 240, 520);
    rectMode(CENTER);
    switch(curserPos){
      case 0:
      rect(140, 353, 95, 15);
      break;

      case 1:
      rect(240, 353, 95, 15);
      break;

      case 2:
      rect(340, 353, 95, 15);
      break;
    }
    rectMode(CORNER);
  }
}
