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
    menuIndex = 6;
  }

  void saveScoreEndless(){
    Score newScore = new Score();
    newScore.tag = name;
    newScore.points = playerManager.score;
    int placeCheck = 0;
    while(placeCheck < 10){
      switch(placeCheck){
        case 0:
          if(playerManager.score > highScoreListEndless.get(0).points){
            highScoreListEndless.add(0, newScore);
            highScoreListEndless.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 1;
          }
        break;
        case 1:
          if(playerManager.score > highScoreListEndless.get(1).points){
            highScoreListEndless.add(1, newScore);
            highScoreListEndless.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 2;
          }
        break;
        case 2:
          if(playerManager.score > highScoreListEndless.get(2).points){
            highScoreListEndless.add(2, newScore);
            highScoreListEndless.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 3;
          }
        break;
        case 3:
          if(playerManager.score > highScoreListEndless.get(3).points){
            highScoreListEndless.add(3, newScore);
            highScoreListEndless.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 4;
          }
        break;
        case 4:
          if(playerManager.score > highScoreListEndless.get(4).points){
            highScoreListEndless.add(4, newScore);
            highScoreListEndless.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 5;
          }
        break;
        case 5:
          if(playerManager.score > highScoreListEndless.get(5).points){
            highScoreListEndless.add(5, newScore);
            highScoreListEndless.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 6;
          }
        break;
        case 6:
          if(playerManager.score > highScoreListEndless.get(6).points){
            highScoreListEndless.add(6, newScore);
            highScoreListEndless.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 7;
          }
        break;
        case 7:
          if(playerManager.score > highScoreListEndless.get(7).points){
            highScoreListEndless.add(7, newScore);
            highScoreListEndless.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 8;
          }
        break;
        case 8:
          if(playerManager.score > highScoreListEndless.get(8).points){
            highScoreListEndless.add(8, newScore);
            highScoreListEndless.remove(10);
            placeCheck = 10;
          }
          else{
            placeCheck = 9;
          }
        break;
        case 9:
          if(playerManager.score > highScoreListEndless.get(9).points){
            highScoreListEndless.add(9, newScore);
            highScoreListEndless.remove(10);
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
    for (int i = 0;  i < highScoreListEndless.size(); i++){
      scoreString += (highScoreListEndless.get(i).toString() + ",");
    }
    scoreArray[0] = scoreString;
    saveStrings("highscoreendless.txt", scoreArray);
    menuIndex = 8;
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

  void showHighScores(){
    fill(255);
    textFont(font,(40));
    textAlign(CENTER);
    text("LEADERBOARDS", 400, 80);
    textFont(font,(30));
    text(highScoreList.get(0).toString(), 400, 140);
    text(highScoreList.get(1).toString(), 400, 180);
    text(highScoreList.get(2).toString(), 400, 220);
    text(highScoreList.get(3).toString(), 400, 260);
    text(highScoreList.get(4).toString(), 400, 300);
    text(highScoreList.get(5).toString(), 400, 340);
    text(highScoreList.get(6).toString(), 400, 380);
    text(highScoreList.get(7).toString(), 400, 420);
    text(highScoreList.get(8).toString(), 400, 460);
    text(highScoreList.get(9).toString(), 400, 500);
    textFont(font,(15));
    text("PRESS 'SPACE' TO RETURN TO MAIN MENU!", 400, 580);
  }

  void showHighScoresEndless(){
    fill(255);
    textFont(font,(40));
    textAlign(CENTER);
    text("ENDLESS LEADERBOARDS", 400, 80);
    textFont(font,(30));
    text(highScoreListEndless.get(0).toString(), 400, 140);
    text(highScoreListEndless.get(1).toString(), 400, 180);
    text(highScoreListEndless.get(2).toString(), 400, 220);
    text(highScoreListEndless.get(3).toString(), 400, 260);
    text(highScoreListEndless.get(4).toString(), 400, 300);
    text(highScoreListEndless.get(5).toString(), 400, 340);
    text(highScoreListEndless.get(6).toString(), 400, 380);
    text(highScoreListEndless.get(7).toString(), 400, 420);
    text(highScoreListEndless.get(8).toString(), 400, 460);
    text(highScoreListEndless.get(9).toString(), 400, 500);
    textFont(font,(15));
    text("PRESS 'SPACE' TO RETURN TO MAIN MENU!", 400, 580);
  }
}
