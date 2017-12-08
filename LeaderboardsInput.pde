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
    Score newScore = new Score();
    newScore.tag = name;
    newScore.points = playerManager.score;
    int placeCheck = 0;
    while(placeCheck < 10){
      switch(placeCheck){
        case 0:
          if(playerManager.score > highScoreList.get(0).points){
            highScoreList.add(0, newScore);
            highScoreList.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 1;
          }
        break;
        case 1:
          if(playerManager.score > highScoreList.get(1).points){
            highScoreList.add(1, newScore);
            highScoreList.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 2;
          }
        break;
        case 2:
          if(playerManager.score > highScoreList.get(2).points){
            highScoreList.add(2, newScore);
            highScoreList.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 3;
          }
        break;
        case 3:
          if(playerManager.score > highScoreList.get(3).points){
            highScoreList.add(3, newScore);
            highScoreList.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 4;
          }
        break;
        case 4:
          if(playerManager.score > highScoreList.get(4).points){
            highScoreList.add(4, newScore);
            highScoreList.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 5;
          }
        break;
        case 5:
          if(playerManager.score > highScoreList.get(5).points){
            highScoreList.add(5, newScore);
            highScoreList.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 6;
          }
        break;
        case 6:
          if(playerManager.score > highScoreList.get(6).points){
            highScoreList.add(6, newScore);
            highScoreList.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 7;
          }
        break;
        case 7:
          if(playerManager.score > highScoreList.get(7).points){
            highScoreList.add(7, newScore);
            highScoreList.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 8;
          }
        break;
        case 8:
          if(playerManager.score > highScoreList.get(8).points){
            highScoreList.add(8, newScore);
            highScoreList.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 9;
          }
        break;
        case 9:
          if(playerManager.score > highScoreList.get(9).points){
            highScoreList.add(9, newScore);
            highScoreList.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 10;
          }
        break;
      }
    }
    String scoreString = "";
    String[] scoreArray = new String[1];
    for (int i = 0;  i < highScoreList.size(); i++){
      scoreString += (highScoreList.get(i).toString() + ",");
    }
    scoreArray[0] = scoreString;
    saveStrings("highscore.txt", scoreArray);
  }

  void displayInput(){
    fill(255);
    textFont(font,(150));
    textAlign(CENTER);
    text(nameconstructor[0], 299, 340);
    text(nameconstructor[1], 399, 340);
    text(nameconstructor[2], 499, 340);
    textFont(font,(15));
    text("USE ARROW KEYS TO SET TAG",390, 480);
    text("PRESS SPACE TO CONFIRM", 399, 520);
    rectMode(CENTER);
    switch(curserPos){
      case 0:
      rect(290, 353, 95, 15);
      break;

      case 1:
      rect(390, 353, 95, 15);
      break;

      case 2:
      rect(490, 353, 95, 15);
      break;
    }
    rectMode(CORNER);
  }
}
