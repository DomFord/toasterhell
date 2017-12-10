/*
Toasterhell, final handin
Made by Dominic Francis Stephen Ford (dofo@itu.dk) and Frederik Boye Hansen (frbh@itu.dk)
ITU 2017, Programming for Designers
*/

import java.io.Serializable;  // Importing various Java libraries, used for saving, loading and sorting the highscoreEntry.
import java.io.*;
import java.util.Collections;
import java.util.Comparator;

LevelManager levelManager;
PlayerManager playerManager;
EnemyManager enemyManager;
PowerUpManager powerUpManager;
LeaderboardsInput leaderboardInput;
MainMenu mainMenu;
ArrayList<Score> highScoreList;
Star[] stars;
int gamestate, ticksElapsed, ticksLastUpdate, menuIndex;
PFont font;

void setup() {
  size(800,600);
  background(0);
  gamestate = 1;
  ticksElapsed = 0;
  ticksLastUpdate = 0;
  menuIndex = 1;

  font = createFont("font.ttf", 100);

  levelManager = new LevelManager();
  playerManager = new PlayerManager();
  enemyManager = new EnemyManager();
  powerUpManager = new PowerUpManager();
  leaderboardInput = new LeaderboardsInput();
  mainMenu = new MainMenu();

  String[] tempScoreList = loadStrings("highscore.txt"); //load in the highscore list and "expand" it into an arraylist of 'Score' objects
  String tempScoreString = tempScoreList[0];
  String[] tempScoreArray = split(tempScoreString, ',');
  highScoreList = new ArrayList<Score>();
  println(tempScoreArray.length);
  for(int i = 0; i < tempScoreArray.length - 1; i++){
    Score newScore = new Score();
    newScore.tag = tempScoreArray[i].substring(0,3);
    newScore.points = int(tempScoreArray[i].substring(4));
    highScoreList.add(newScore);
  }
  println(highScoreList.get(0));
  println(highScoreList.get(1));
  println(highScoreList.get(2));
  println(highScoreList.get(3));
  println(highScoreList.get(4));
  println(highScoreList.get(5));
  println(highScoreList.get(6));
  println(highScoreList.get(7));
  println(highScoreList.get(8));
  println(highScoreList.get(9));

  stars = new Star[10];
  for (int i = 0; i < 10; i++) {
    stars[i] = new Star();
  }
}

void keyPressed() {
  switch (menuIndex) {
    case 1:
      if (key == ' ') {
        if (mainMenu.introDone) {
          menuIndex++;
        } else {
          mainMenu.ypos = height - 100;
        }
      }
    break;
    case 2:
      switch (keyCode) {
        case UP:
          if (mainMenu.indicator > 1) {
            mainMenu.indicator--;
          }
        break;
        case DOWN:
          if (mainMenu.indicator < 4) {
            mainMenu.indicator++;
          }
        break;
        case LEFT:
          if (playerManager.playerSelect > 1) {
            playerManager.playerSelect--;
          } else {
            playerManager.playerSelect = 2;
          }
          playerManager.avatarStatSetter();
        break;
        case RIGHT:
          if (playerManager.playerSelect < 2) {
            playerManager.playerSelect++;
          } else {
            playerManager.playerSelect = 1;
          }
          playerManager.avatarStatSetter();
        break;
        case ENTER:
        case RETURN:
          switch (mainMenu.indicator) {
            case 1:
              menuIndex = 3;
            break;
            case 2:
              menuIndex = 4;
            break;
            case 3:
              menuIndex = 5;
            break;
            case 4:
              exit();
            break;
          }
        break;
      }
    if (key == ' ') {
      switch (mainMenu.indicator) {
        case 1:
          menuIndex = 3;
        break;
        case 2:
          menuIndex = 4;
        break;
        case 3:
          menuIndex = 5;
        break;
        case 4:
          exit();
        break;
      }
    }
    break;
    case 3:
      switch (keyCode) {
        case LEFT:
          playerManager.left = true;
        break;
        case RIGHT:
          playerManager.right = true;
        break;
        case UP:
          playerManager.up = true;
        break;
        case DOWN:
          playerManager.down = true;
        break;
      }
      switch (key) {
        case ' ':
          playerManager.shooting = true;
        break;
        case '1':
          gamestate = 1;
        break;
        case '2':
          gamestate = 2;
        break;
        case '3':
          gamestate = 3;
        break;
        case '4':
          gamestate = 4;
        break;
        case '5':
          gamestate = 5;
        break;
        case '6':
          gamestate = 6;
        break;
      }
      break;
    case 4:
      switch (keyCode) {
        case LEFT:
          playerManager.left = true;
        break;
        case RIGHT:
          playerManager.right = true;
        break;
        case UP:
          playerManager.up = true;
        break;
        case DOWN:
          playerManager.down = true;
        break;
      }
      if (key == ' ') {
        gamestate++;
        menuIndex--;
      }
    break;
    case 5:
      switch (keyCode) {
        case UP:
          if (leaderboardInput.letterSelect < 35) {
            leaderboardInput.letterSelect++;
            leaderboardInput.nameconstructor[leaderboardInput.curserPos] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
          }
          else {
            leaderboardInput.letterSelect = 0;
            leaderboardInput.nameconstructor[leaderboardInput.curserPos] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
          }
        break;
        case DOWN:
          if (leaderboardInput.letterSelect > 0) {
            leaderboardInput.letterSelect--;
            leaderboardInput.nameconstructor[leaderboardInput.curserPos] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
          }
          else {
            leaderboardInput.letterSelect = 35;
            leaderboardInput.nameconstructor[leaderboardInput.curserPos] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
          }
        break;
        case RIGHT:
          switch (leaderboardInput.curserPos) {
            case 0:
              leaderboardInput.nameconstructor[0] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
              leaderboardInput.letter1 = leaderboardInput.letterSelect;
              leaderboardInput.letterSelect = leaderboardInput.letter2;
            break;
            case 1:
              leaderboardInput.nameconstructor[1] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
              leaderboardInput.letter2 = leaderboardInput.letterSelect;
              leaderboardInput.letterSelect = leaderboardInput.letter3;
            break;
            case 2:
              leaderboardInput.nameconstructor[2] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
              leaderboardInput.letter3 = leaderboardInput.letterSelect;
              leaderboardInput.letterSelect = leaderboardInput.letter1;
            break;
          }
          if (leaderboardInput.curserPos < 2) {
            leaderboardInput.curserPos++;
          }
          else {
            leaderboardInput.curserPos = 0;
          }
        break;
        case LEFT:
          switch (leaderboardInput.curserPos) {
            case 0:
              leaderboardInput.nameconstructor[0] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
              leaderboardInput.letter1 = leaderboardInput.letterSelect;
              leaderboardInput.letterSelect = leaderboardInput.letter3;
            break;
            case 1:
              leaderboardInput.nameconstructor[1] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
              leaderboardInput.letter2 = leaderboardInput.letterSelect;
              leaderboardInput.letterSelect = leaderboardInput.letter1;
            break;
            case 2:
              leaderboardInput.nameconstructor[2] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
              leaderboardInput.letter3 = leaderboardInput.letterSelect;
              leaderboardInput.letterSelect = leaderboardInput.letter2;
            break;
          }
          if (leaderboardInput.curserPos > 0) {
            leaderboardInput.curserPos--;
          }
          else {
            leaderboardInput.curserPos = 2;
          }
        break;
        case ENTER:
        case RETURN:
          leaderboardInput.saveScore();
        break;
      }
      break;
      case 6:
        menuIndex = 2;
      break;
  }
}

void keyReleased() {
  switch (menuIndex) {
    case 3:
    case 4:
      switch (keyCode) {
        case LEFT:
          playerManager.left = false;
          break;
        case RIGHT:
          playerManager.right = false;
          break;
        case UP:
          playerManager.up = false;
          break;
        case DOWN:
          playerManager.down = false;
          break;
      }
      switch (key) {
        case ' ':
          playerManager.shooting = false;
        break;
      }
    break;
  }
}

void draw() {
  switch (menuIndex) {
    case 1:
      mainMenu.drawMenu();
    break;
    case 2:
      mainMenu.menuSelect();
    break;
    case 3:
      switch (gamestate) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
          levelManager.levelSelector();
          enemyManager.enemySpawner();
          powerUpManager.powerUpSpawner();
          playerManager.drawPlayer();
          ticksElapsed++;
          ticksLastUpdate = millis();
          fill(255);
          text(enemyManager.enemyCounter, width / 2, height / 2);
        break;
      }
    break;
    case 4:
    levelManager.levelSelector();
    playerManager.drawPlayer();
    ticksElapsed++;
    ticksLastUpdate = millis();
    break;
    case 5:
      background(0);
      leaderboardInput.showBoard();
      leaderboardInput.displayInput();
    break;
    case 6:
      background(0);
      leaderboardInput.showHighScores();
    break;
  }
}
