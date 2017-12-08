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
HighscoreEntry highscoreEntry;
Highscores highscores;
LeaderboardsInput leaderboardInput;
ArrayList<PlayerManager> players;
ArrayList<Score> scores;
Star[] stars;
int gamestate, ticksElapsed, ticksLastUpdate, menuIndex;
PFont font;

void setup() {
  size(800,600);
  background(0);
  gamestate = 1;
  ticksElapsed = 0;
  ticksLastUpdate = 0;
  menuIndex = 2;

  font = createFont("font.ttf", 100);

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
  }

  if(menuIndex == 4){
    if(key == CODED){
      if(keyCode == UP){
        if(leaderboardInput.letterSelect < 35){
          leaderboardInput.letterSelect++;
          leaderboardInput.nameconstructor[leaderboardInput.curserPos] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
        }
        else{
          leaderboardInput.letterSelect = 0;
          leaderboardInput.nameconstructor[leaderboardInput.curserPos] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
        }
      }
      if(keyCode == DOWN){
        if(leaderboardInput.letterSelect > 0){
          leaderboardInput.letterSelect--;
          leaderboardInput.nameconstructor[leaderboardInput.curserPos] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
        }
        else{
          leaderboardInput.letterSelect = 35;
          leaderboardInput.nameconstructor[leaderboardInput.curserPos] = leaderboardInput.alphabet[leaderboardInput.letterSelect];
        }
      }
      if(keyCode == RIGHT){
        switch(leaderboardInput.curserPos){
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
        if(leaderboardInput.curserPos < 2){
          leaderboardInput.curserPos++;
        }
        else{
          leaderboardInput.curserPos = 0;
        }
      }
      if(keyCode == LEFT){
        switch(leaderboardInput.curserPos){
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
        if(leaderboardInput.curserPos > 0){
          leaderboardInput.curserPos--;
        }
        else{
          leaderboardInput.curserPos = 2;
        }
      }
    }
    if(key == ENTER){
      leaderboardInput.saveScore();
    }
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
