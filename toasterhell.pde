/*
Toasterhell, final handin
Made by Dominic Francis Stephen Ford (dofo@itu.dk) and Frederik Boye Hansen (frbh@itu.dk)
ITU 2017, Programming for Designers
*/

import java.io.Serializable;  // Importing various Java libraries, used for saving, loading and sorting the highscoreEntry.
import java.io.*;
import java.util.Collections;
import java.util.Comparator;

MainMenu mainMenu;
LevelManager levelManager;
PlayerManager playerManager;
EnemyManager enemyManager;
HighscoreEntry highscoreEntry;
Highscores highscores;
LeaderboardsInput leaderboardInput;
ArrayList<PlayerManager> players;
ArrayList<Score> scores;
Star[] stars;
int gamestate, ticksElapsed, ticksLastUpdate, menuIndex;
PFont font1, font2;

void setup() {
  size(800,600);
  background(0);
  gamestate = 1;
  ticksElapsed = 0;
  ticksLastUpdate = 0;
  menuIndex = 1;

  font1 = createFont("font.ttf", 100);
  font2 = createFont("LondrinaShadow-Regular.ttf", 100);

  mainMenu = new MainMenu();
  levelManager = new LevelManager();
  playerManager = new PlayerManager();
  enemyManager = new EnemyManager();
  highscoreEntry = new HighscoreEntry();
  highscores = new Highscores();
  leaderboardInput = new LeaderboardsInput();
  scores = FileManager.loadScore("memes.dat");

  stars = new Star[10];
  for (int i = 0; i < 10; i++) {
    stars[i] = new Star();
  }

}

void keyPressed() {
  /* switch for debugging */
  switch (key) {
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
    case '7':
      gamestate = 7;
    break;
  }

  switch (menuIndex) {
    case 1:
      if (key == ' ') {
        mainMenu.spacePressed = true;
      }
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
        case RETURN:
        case ENTER:
          switch (mainMenu.indicator) {
            case 1:
              menuIndex = 2;
            break;
            case 2:
              menuIndex = 3;
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
    break;
  }

  switch (gamestate) {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
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
      }
    case 6:
      switch (keyCode) {
        case DOWN:
          if (highscoreEntry.letterRoll == highscoreEntry.alphabet.length - 1) {
            highscoreEntry.letterRoll = 0;
          } else {
            highscoreEntry.letterRoll++;
          }
        break;
        case UP:
          if (highscoreEntry.letterRoll <= 0) {
            highscoreEntry.letterRoll = highscoreEntry.alphabet.length - 1;
          } else {
            highscoreEntry.letterRoll--;
          }
        break;
        case ENTER:
        case RETURN:
          if (highscoreEntry.letterSelect <= 2) {
            highscoreEntry.lockLetter(highscoreEntry.letterRoll);
          } else {
            highscoreEntry.setName();
            gamestate++;
          }
        break;

        case BACKSPACE:
          if (highscoreEntry.letterSelect >= 0) {
            highscoreEntry.deleteLetter();
          }
        break;
        }

    break;
  }
}

void keyReleased() {
  switch (gamestate) {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
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
  switch (menuIndex){
    case 1:
    mainMenu.drawMenu();
    break;
    case 2:
      switch (gamestate) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        levelManager.levelSelector();
        enemyManager.enemySpawner();
        playerManager.drawPlayer();
        ticksElapsed++;
        ticksLastUpdate = millis();
        break;
      }
    break;
    case 3:
    break;
    case 4:
      background(0);
      leaderboardInput.showBoard();
      leaderboardInput.displayInput();
    break;
    case 5:
      highscores.displayHighscores();
    break;
  }
}
