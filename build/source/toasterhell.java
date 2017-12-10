import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.io.Serializable; 
import java.io.*; 
import java.util.Collections; 
import java.util.List; 
import java.util.Comparator; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class toasterhell extends PApplet {

/*
Toasterhell, final handin
Made by Dominic Francis Stephen Ford (dofo@itu.dk) and Frederik Boye Hansen (frbh@itu.dk)
ITU 2017, Programming for Designers
*/

  // Importing various Java libraries, used for saving, loading and sorting the highscoreEntry.





LevelManager levelManager;
PlayerManager playerManager;
EnemyManager enemyManager;
PowerUpManager powerUpManager;
LeaderboardsInput leaderboardInput;
MainMenu mainMenu;
ArrayList<Score> highScoreList;
ArrayList<Score> highScoreListEndless;
Star[] stars;
int gamestate, ticksElapsed, ticksLastUpdate, menuIndex;
PFont font;

public void setup() {
  
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
  for(int i = 0; i < tempScoreArray.length - 1; i++){
    Score newScore = new Score();
    newScore.tag = tempScoreArray[i].substring(0,3);
    newScore.points = PApplet.parseInt(tempScoreArray[i].substring(4));
    highScoreList.add(newScore);
  }

  String[] tempScoreListEndless = loadStrings("highscoreendless.txt"); //load in the highscore list and "expand" it into an arraylist of 'Score' objects
  String tempScoreStringEndless = tempScoreListEndless[0];
  String[] tempScoreArrayEndless = split(tempScoreStringEndless, ',');
  highScoreListEndless = new ArrayList<Score>();
  for(int i = 0; i < tempScoreArrayEndless.length - 1; i++){
    Score newScoreEndless = new Score();
    newScoreEndless.tag = tempScoreArrayEndless[i].substring(0,3);
    newScoreEndless.points = PApplet.parseInt(tempScoreArrayEndless[i].substring(4));
    highScoreListEndless.add(newScoreEndless);
  }


  stars = new Star[10];
  for (int i = 0; i < 10; i++) {
    stars[i] = new Star();
  }
}

public void keyPressed() { //handles all the keyboard input for the different screens
  if (key == '0') {
    if (playerManager.godmode) {
      playerManager.godmode = false;
    } else {
      playerManager.godmode = true;
    }
  }
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
          if (mainMenu.indicator < 5) {
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
              playerManager.avatarStatSetter();
              menuIndex = 3;
            break;
            case 2:
              playerManager.avatarStatSetter();
              gamestate = 6;
              menuIndex = 3;
            break;
            case 3:
              menuIndex = 5;
            break;
            case 4:
              menuIndex = 8;
            break;
            case 5:
              exit();
            break;
          }
        break;
      }
    if (key == ' ') {
      switch (mainMenu.indicator) {
        case 1:
          playerManager.avatarStatSetter();
          menuIndex = 3;
        break;
        case 2:
          playerManager.avatarStatSetter();
          gamestate = 6;
          menuIndex = 3;
        break;
        case 3:
          menuIndex = 6;
        break;
        case 4:
          menuIndex = 8;
        break;
        case 5:
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
        case 'a':
          enemyManager.enemyCounter = 20;
          levelManager.advanceGamestate();
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
    case 7:
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
          if (gamestate <= 5){
            leaderboardInput.saveScore();
          }
          else if (gamestate == 6){
            leaderboardInput.saveScoreEndless();
          }
        break;
      }
      if (key == ' ') {
        if (gamestate <= 5){
          leaderboardInput.saveScore();
        }
        else if (gamestate == 6){
          leaderboardInput.saveScoreEndless();
        }
      }
      break;
      case 6:
      case 8:
        menuIndex = 2;
      break;
  }
}

public void keyReleased() { //checks keyrelease to enable continious movement of the player
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

public void draw() { //draws the corresponding elements for the different game states
  switch (menuIndex) {
    case 1:
      mainMenu.drawMenu();
    break;
    case 2:
      mainMenu.menuSelect();
    break;
    case 3:
      levelManager.levelSelector();
      enemyManager.enemySpawner();
      powerUpManager.powerUpSpawner();
      playerManager.drawPlayer();
      ticksElapsed++;
      ticksLastUpdate = millis();
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
    case 7:
      background(0);
      leaderboardInput.showBoard();
      leaderboardInput.displayInput();
    break;
    case 8:
      background(0);
      leaderboardInput.showHighScoresEndless();
    break;
  }
}
class BasicEnemy {
  int timeStamp, shootRateModifier, shootCounter, ticksLast, cycleCount,xMove, yMove, enemyState;
  float xpos, ypos, speed1, speed2, speed3, speed4, speed5, size, leftSpeed, rightSpeed, upSpeed, downSpeed, speedModifier, brakeModifier;
  boolean alive, shooting;
  ArrayList<EnemyBullet> bullets;
  PImage enemyImage1, enemyImage2, enemyImage3, enemyImage4, enemyImage5;
  PImage[] enemyImages;

  BasicEnemy(int level) {
    xMove = 0;
    yMove = 0;
    enemyState = level;
    cycleCount = 0;
    ticksLast = millis();
    shootCounter = 0;
    timeStamp = 0;
    shootRateModifier = 60;
    xpos = random(0 + size, width - size);
    ypos = -100;
    speed1 = 50;
    speed2 = 70;
    speed3 = 90;
    speed4 = 110;
    speed5 = 130;
    size = 50;
    leftSpeed = 0;
    rightSpeed = 0;
    upSpeed = 0;
    downSpeed = 0;
    speedModifier = 0.2f;
    brakeModifier = 0.5f;
    alive = true;
    shooting = true;
    bullets = new ArrayList<EnemyBullet>();
    enemyImage1 = loadImage("enemy_grass.png");
    enemyImage2 = loadImage("enemy_water.png");
    enemyImage3 = loadImage("enemy_rock.png");
    enemyImage4 = loadImage("enemy_ice.png");
    enemyImage5 = loadImage("enemy_lava.png");
    enemyImages = new PImage[5];
      enemyImages[0] = enemyImage1;
      enemyImages[1] = enemyImage2;
      enemyImages[2] = enemyImage3;
      enemyImages[3] = enemyImage4;
      enemyImages[4] = enemyImage5;
  }

  public void drawEnemy() { //draws the enemy depending on level selected shows different images
    if (alive) {
      move();
      bulletCollision();
      shootHandler();
      imageMode(CENTER);
      image(enemyImages[enemyState - 1], xpos, ypos);
      } else {
        //death();
      }
    }

    public void move() { //handles the different movement patterns for the various enemies
      switch (enemyState){
        case 1:
          ypos += speed1 * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
        break;
        case 2:
          if (xMove < 250){
            xpos += speed1 * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
            xMove ++;
          }
          else if (xMove < 500){
            xpos -= speed2 * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
            xMove ++;
          }
          else{
            xMove = 0;
          }
          if (yMove < 250){
            ypos += speed3 * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
            yMove ++;
          }
          else if (yMove < 500){
            yMove ++;
          }
          else{
            yMove = 0;
          }
        break;
        case 3:
          if (xMove < 50){
            xpos += speed2 * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
            xMove ++;
          }
          else if (xMove < 100){
            xpos -= speed2 * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
            xMove ++;
          }
          else{
            xMove = 0;
          }
          if (yMove < 100){
            ypos += speed4 * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
            yMove ++;
          }
          else if (yMove < 150){
            yMove ++;
          }
          else{
            yMove = 0;
          }
        break;
        case 4:
          if (xMove < 50){
            xpos += speed5 * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
            xMove ++;
          }
          else if (xMove < 100){
            xpos -= speed5 * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
            xMove ++;
          }
          else{
            xMove = 0;
          }
          if (yMove < 100){
            ypos += speed4 * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
            yMove ++;
          }
          else if (yMove < 150){
            yMove ++;
          }
          else{
            yMove = 0;
          }
        break;
        case 5:
          if (xMove < 50){
            xpos += speed1 * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
            xMove ++;
          }
          else if (xMove < 250){
            xMove ++;
          }
          else if (xMove < 300){
            xpos -= speed1 * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
            xMove ++;
          }
          else if (xMove < 500){
            xMove ++;
          }
          else{
            xMove = 0;
          }
          if (yMove < 50){
            yMove ++;
          }
          else if (yMove < 100){
            ypos += speed3 * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
            yMove ++;
          }
          else if (yMove < 250){
            yMove ++;
          }
          else{
            yMove = 0;
          }
        break;
      }
    }

    public void bulletCollision() { //checks collision with player bullets and calls to kill the enemy and remove the player bullet
        for (int i = playerManager.bullets.size() - 1; i >= 0; i--) {
          if (playerManager.bullets.get(i).xpos - playerManager.bullets.get(i).size / 2 > xpos - size / 2
              && playerManager.bullets.get(i).xpos + playerManager.bullets.get(i).size / 2 < xpos + size / 2
              && playerManager.bullets.get(i).ypos - playerManager.bullets.get(i).size / 2 > ypos - size / 2
              && playerManager.bullets.get(i).ypos + playerManager.bullets.get(i).size / 2 < ypos + size / 2) {
                alive = false;
                playerManager.bullets.remove(i);
                playerManager.score += enemyState * 10;
              }
        }
    }

    public void shootHandler() { //controls the various shooting patterns for the different enemy types
      if (shooting) {
        int delta = millis() - ticksLast;
        switch (enemyState){
          case 1:
          shootRateModifier = 2000;
          if (delta > shootRateModifier) {
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
            ticksLast += delta;
          }
          break;
          case 2:
          shootRateModifier = 2500;
          if (delta > shootRateModifier) {
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
            ticksLast += delta;
          }
          break;
          case 3:
            shootCounter = 500;
            if (delta > shootCounter && cycleCount < 3){
              bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
              ticksLast += delta;
              cycleCount++;
            }
            else if (delta > shootCounter && cycleCount > 2){
              ticksLast += delta;
              cycleCount++;
            }
            else if (cycleCount >= 10){
              ticksLast += delta;
              cycleCount = 0;
            }
          break;
          case 4:
          shootCounter = 400;
          if (delta > shootCounter && cycleCount < 3){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount > 2){
            ticksLast += delta;
            cycleCount++;
          }
          else if (cycleCount >= 8){
            ticksLast += delta;
            cycleCount = 0;
          }
          break;
          case 5:
          shootCounter = 300;
          if (delta > shootCounter && cycleCount == 0){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 1){
            bullets.add(new EnemyBullet(xpos, ypos, -100, 100));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 2){
            bullets.add(new EnemyBullet(xpos, ypos, -150, 00));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 3){
            bullets.add(new EnemyBullet(xpos, ypos, -100, -100));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 4){
            bullets.add(new EnemyBullet(xpos, ypos, 0, -150));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 5){
            bullets.add(new EnemyBullet(xpos, ypos, 100, -100));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 6){
            bullets.add(new EnemyBullet(xpos, ypos, 150, 0));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 7){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 100));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 8){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount > 8){
            ticksLast += delta;
            cycleCount++;
          }
          else if (cycleCount >= 20){
            ticksLast += delta;
            cycleCount = 0;
          }
          break;
        }
      }
      for (int i = bullets.size() - 1; i >= 0; i--) {
        bullets.get(i).drawBullet();
        if (bullets.get(i).ypos > height) {
          bullets.remove(i);
        }
      }
    }
}
class EnemyBullet {
  float xpos, ypos, ySpeed, xSpeed, size;
  boolean collided;

  EnemyBullet(float x, float y, float xs, float ys) {
    xpos = x;
    ypos = y;
    ySpeed = ys;
    xSpeed = xs;
    size = 10;
  }

  public void drawBullet() { //draws a simple bullet for the enemies
    rectMode(CENTER);
    fill(218, 44, 56);
    stroke(255, 255, 56);
    rect(xpos, ypos, size, size);
    ypos += ySpeed * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
    xpos += xSpeed * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
  }
}
class EnemyManager {
  ArrayList<BasicEnemy> basicEnemies;
  ArrayList<EnemyBullet> bullets;
  int timeStamp, enemyCounter, maxEnemies;

  EnemyManager() {
    enemyCounter = 0;
    basicEnemies = new ArrayList<BasicEnemy>();
    bullets = new ArrayList<EnemyBullet>();
    timeStamp = 0;
  }

  public void enemySpawner() { //handles spawning of enemies at regular intervals depending on game mode selected and removes them when they get out of screen bounds
    enemyKiller();
    if (gamestate < 6) {
      if (enemyCounter >= 20) {
        for (int i = basicEnemies.size() - 1; i >= 0; i--) {
          basicEnemies.remove(i);
        }
        for (int i = bullets.size() - 1; i >= 0; i--) {
          bullets.remove(i);
        }
        for (int i = powerUpManager.powerUps.size() - 1; i >= 0; i--) {
          powerUpManager.powerUps.remove(i);
        }
        menuIndex++;
        enemyCounter = 0;
        maxEnemies = 0;
      } else {
        if (ticksElapsed > timeStamp + 100 && maxEnemies < 20) {
          basicEnemies.add(new BasicEnemy(gamestate));
          timeStamp = ticksElapsed;
          maxEnemies ++;
        }
      }
  } else {
    if (ticksElapsed > timeStamp + 100) {
      basicEnemies.add(new BasicEnemy((int)random(1, 5)));
      timeStamp = ticksElapsed;
    }
  }

    for (int i = basicEnemies.size() - 1; i >= 0; i--) {
      basicEnemies.get(i).drawEnemy();
    }

    for (int i = bullets.size() - 1; i >= 0; i--) {
      bullets.get(i).drawBullet();
      if (bullets.get(i).ypos > height) {
        bullets.remove(i);
      }
      else if (bullets.get(i).ypos < 0) {
        bullets.remove(i);
      }
      else if (bullets.get(i).xpos < 0) {
        bullets.remove(i);
      }
      else if (bullets.get(i).xpos > width) {
        bullets.remove(i);
      }
    }
  }

  public void enemyKiller() { //removes the enemy when it gets shot and creates a deathblossom of bullets
    for (int i = basicEnemies.size() - 1; i >= 0; i--) {
      if (!basicEnemies.get(i).alive) {
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 0, 150));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 0, -150));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 150, 0));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, -150, 0));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, -100, 100));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, -100, -100));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 100, -100));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 100, 100));
        basicEnemies.remove(i);
        enemyCounter++;
      }
    }
    for (int i = basicEnemies.size() - 1; i >= 0; i--) {
      if (basicEnemies.get(i).ypos > height + 100) {
        basicEnemies.remove(i);
        enemyCounter++;
      }
    }
  }
}
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


  public void showBoard(){ //this is just merging the selected letters into a single string
    name = join(nameconstructor, "");
  }

  public void saveScore(){ //here, the score is iterated through the list and put in its appropriate place. After that is done, it deletes the 11th entry and saves the list to a file.
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

  public void saveScoreEndless(){ //here, the endless score is iterated through the list and put in its appropriate place. After that is done, it deletes the 11th entry and saves the list to a file.
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

  public void displayInput(){ //This displays the input screen where you can dial in your name tag.
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

  public void showHighScores(){ //this displays the 10 entries on the highscore list
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

  public void showHighScoresEndless(){ //this displays the ten entries on the endless highscore list
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
/*
This script deals with levels; it handles what level is selected and how each level plays out etc.
*/
class LevelManager{
  int bgColour;
  int backgroundyPos, a, switchScreenX, switchScreenX2;
  PImage backgroundGrass, backgroundWater, backgroundRock, backgroundIce, backgroundLava, backgroundCrystal;
  PImage[] backgrounds;

  LevelManager() {
    backgroundyPos = 0;
    a = 0;
    backgroundGrass = loadImage("grass.png");
    backgroundWater = loadImage("water.png");
    backgroundRock = loadImage("rocks.png");
    backgroundIce = loadImage("ice.png");
    backgroundLava = loadImage("lava.png");
    backgroundCrystal = loadImage("crystal.png");
    backgroundGrass.resize(width,0);
    backgroundWater.resize(width,0);
    backgroundRock.resize(width,0);
    backgroundIce.resize(width,0);
    backgroundLava.resize(width,0);
    backgroundCrystal.resize(width,0);
    backgrounds = new PImage[6];
      backgrounds[0] = backgroundGrass;
      backgrounds[1] = backgroundWater;
      backgrounds[2] = backgroundRock;
      backgrounds[3] = backgroundIce;
      backgrounds[4] = backgroundLava;
      backgrounds[5] = backgroundCrystal;
  }

  public void levelSelector() { //handles the advance in levels from 1-6 and checks your highscore at the end
      switch (menuIndex) {
      case 3:
        drawBackground(backgrounds[gamestate - 1]);
      break;
      case 4:
        if(gamestate <= 4){
          enemyManager.maxEnemies = 0;
          advanceGamestate();
        }
        else{
          if(playerManager.score > highScoreList.get(9).points){  //checks if the player has set a new highscore better than the lowest one currently on the list
            menuIndex = 5;
          }
          else{
            menuIndex = 6;
          }
        }
      break;
    }
  }

  public void drawBackground(PImage level) { //draws a continuously scrolling background
    image(level, width / 2, backgroundyPos);
    image(level, width / 2, (backgroundyPos-level.height));
    backgroundyPos++;
    if(backgroundyPos >= level.height){
      backgroundyPos = 0;
    }
    starParticles();
  }

  public void advanceGamestate() { //shows a fancy animation between levels
    int nextLevel = gamestate + 1;
    background(0, 0, 0, a);
    textFont(font, 50);
    fill (255, 255, 255, a);
    textAlign(CENTER, CENTER);
    text("LEVEL " + nextLevel, switchScreenX, height / 2);
    textAlign(CENTER, CENTER);
    if (millis() / 1000 % 2 == 0) {
      text("press SPACE to continue", width / 2, height - 200);
    }
    if (a < 255) {
      a++;
    }
    if (switchScreenX < width / 2) {
      switchScreenX += 5;
    }
    if (switchScreenX2 > width / 2) {
      switchScreenX2 += 10;
    }
  }

  public void starParticles() { //shows little particles to emulate wind and a feeling of flying forwards
    for (int i = 0; i < stars.length; i++) {
      stars[i].moveStar();
    }
  }
}
class MainMenu {
  int avatarFrame, ticksLast, frameDuration, x1, x2, y, indicator, indicatorY, backgroundyPos;
  float xpos, ypos, speed;
  boolean introDone;
  PImage player1sheet, player2sheet, backgroundGrass;
  PImage[] avatars;

  MainMenu() {
    avatarFrame = 0;
    ticksLast = millis();
    frameDuration = 100;
    xpos = width / 2;
    ypos = -200;
    x1 = -100;
    x2 = width + 100;
    y = 200;
    indicator = 1;
    indicatorY = 155;
    backgroundyPos = 0;
    speed = 5;
    introDone = false;
    player1sheet = loadImage("player_avatar_1.png");
    player2sheet = loadImage("player_avatar_2.png");
    avatars = new PImage[2];
      avatars[0] = player1sheet;
      avatars[1] = player2sheet;
    backgroundGrass = loadImage("grass.png");
    backgroundGrass.resize(width,0);
  }

  public void introAnimation() { //shows a cool title screen animation
    PImage f = player1sheet.get((avatarFrame*60),0,60,66);
    imageMode(CENTER);
    image(f, xpos, ypos);
    int delta = millis() - ticksLast;
    if (delta >= frameDuration) {
      avatarFrame++;
      if (avatarFrame >= 3) {
        avatarFrame = 0;
      }
      ticksLast += delta;
    }
    if (ypos < height - 100) {
      ypos += speed;
      if (ypos > height / 2 && speed > 1) {
        speed -= 0.1f;
      }
      } else {
        introDone = true;
      }
    }

    public void drawBackground() { //draws the background on the intro screen
      image(backgroundGrass,width/2,backgroundyPos);
      image(backgroundGrass,width/2,(backgroundyPos-backgroundGrass.height));
      backgroundyPos++;
      if (backgroundyPos >= backgroundGrass.height) {
        backgroundyPos = 0;
      }
    }

    public void drawAvatar(PImage avatar) { //animates a little toaster to fly in
      imageMode(CENTER);
      PImage f = avatar.get((avatarFrame*60),0,60,66);
      image(f,xpos,ypos);
      int delta = millis() - ticksLast;
      if (delta >= frameDuration){
        avatarFrame++;
        if(avatarFrame >= 3){
          avatarFrame = 0;
        }
        ticksLast += delta;
      }
    }

    public void drawMenu() { //decides whether to show the intro animation or show the menu selection
        drawBackground();
        if (!introDone) {
          introAnimation();
          } else {
            drawAvatar(avatars[playerManager.playerSelect - 1]);
            menuTextSlide();
          }
      }

      public void menuTextSlide() { //slides in the title
        drawBackground();
        drawAvatar(avatars[playerManager.playerSelect - 1]);
        fill(255);
        textAlign(RIGHT);
        textFont(font, 50);
        text("Welcome to", x1, y);
        textAlign(LEFT);
        textFont(font, 75);
        text("TOASTERHELL", x2, y + 100);
        if (x1 < width / 2 && x2 > width / 5) {
          x1 += 5;
          x2 -= 10;
        }
        textFont(font, 40);
        textAlign(CENTER, CENTER);
        if (millis() / 1000 % 2 == 0)
        text("Press SPACE", width / 2, height - 200);
      }

      public void menuSelect() { //shows the menu selections
        drawBackground();
        drawAvatar(avatars[playerManager.playerSelect - 1]);
        fill(255);
        textAlign(LEFT, CENTER);
        textFont(font, 50);
        text("CAMPAIGN", 100, 150);
        text("ENDLESS", 100, 250);
        text("HISCORES", 100, 350);
        text("ENDLESS HISCORES", 100, 450);
        text("EXIT", 100, 550);
        textAlign(RIGHT, CENTER);
        textFont(font, 32);
        if (millis() / 100 % 20 != 0) {
          text("press ENTER or SPACE to select\n arrow keys to change avatar", width - 50, 50);
        }
        rectMode(CENTER);
        if (millis() / 100 % 5 == 0) {
          if (indicator < 5) {
            indicatorY = 55 + (indicator * 100);
          } else {
            indicatorY = 555;
          }
          rect(75, indicatorY, 10, 40);
        }
      }
    }
class PlayerBullet {
  float xpos, ypos, speed, size;
  boolean collided;

  PlayerBullet(float x, float y) {
    xpos = x;
    ypos = y;
    speed = 200;
    size = 3;
  }

  public void drawBullet() { //draws a simple player bullet
    rectMode(CENTER);
    fill(255);
    stroke(0,120,255);
    rect(xpos, ypos, size, size * 5);

    if (!collided) {
      ypos -= speed * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
    }
  }
}
/*
This script handles the player, both what player is selected, player life, weapon, controls etc.
*/
class PlayerManager{
  int timeStamp, shootRateModifier, playerSelect, avatarFrame, ticksLast, frameDuration, score, health, maxHealth;
  float xpos, ypos, maxSpeed, size, leftSpeed, rightSpeed, upSpeed, downSpeed, speedModifier, brakeModifier, hitBlinkOpacity;
  boolean left, right, up, down, shooting, godmode;
  ArrayList<PlayerBullet> bullets;
  PImage player1sheet, player2sheet, heart;

  PlayerManager() {
    timeStamp = 0;
    xpos = width / 2;
    ypos = height - 75;
    maxSpeed = 400;
    size = 30;
    left = false;
    right = false;
    up = false;
    down = false;
    shooting = false;
    leftSpeed = 0;
    rightSpeed = 0;
    upSpeed = 0;
    downSpeed = 0;
    hitBlinkOpacity = 0;
    speedModifier = 20;
    brakeModifier = 30;
    bullets = new ArrayList<PlayerBullet>();
    player1sheet = loadImage("player_avatar_1.png");
    player2sheet = loadImage("player_avatar_2.png");
    heart = loadImage("heart.png");
    playerSelect = 1;
    avatarFrame = 0;
    ticksLast = millis();
    frameDuration = 100;
    score = 0;
    health = 3;
    shootRateModifier = 10;
  }

  public void avatarStatSetter() { //this deals with the stats of the two different player avatars - health, speed and shoot rate.
    enemyManager.enemyCounter = 0;
    enemyManager.maxEnemies = 0;
    gamestate = 1;
    leftSpeed = 0;
    rightSpeed = 0;
    upSpeed = 0;
    downSpeed = 0;
    xpos = width / 2;
    ypos = height - 75;
    left = false;
    right = false;
    up = false;
    down = false;
    left = false;
    right = false;
    up = false;
    down = false;
    shooting = false;
    score = 0;
    if (playerSelect == 1) {
      maxHealth = 3;
      health = 3;
      shootRateModifier = 10;
      speedModifier = 20;
    } else {
      maxHealth = 5;
      health = 5;
      shootRateModifier = 25;
      speedModifier = 10;
    }
  }

  public void drawPlayer() { //this draws the player at the location defined by the movePlayer function, shows a different picture for the two avatars.
    speedHandler();
    movePlayer();
    shootHandler();
    displayScore();
    displayCurrentLevel();

    if(health <= 0){
      death();
    }
    imageMode(CENTER);
    if(playerSelect == 1){
      PImage f = player1sheet.get((avatarFrame*60),0,60,66);
      image(f,xpos,ypos);
      int delta = millis() - ticksLast;
      if (delta >= frameDuration){
        avatarFrame++;
        if(avatarFrame >= 3){
          avatarFrame = 0;
        }
        ticksLast += delta;
      }
    }
    else if (playerSelect == 2) {
      PImage f = player2sheet.get((avatarFrame*60),0,60,66);
      image(f,xpos,ypos);
      int delta = millis() - ticksLast;
      if (delta >= frameDuration) {
        avatarFrame++;
        if(avatarFrame >= 3) {
          avatarFrame = 0;
        }
        ticksLast += delta;
        }
      }
    }

  public void movePlayer() { //here, movement is controlled and some movement related functions are called.
    speedHandler();
    shootHandler();
    bulletCollision();
    powerUpCollision();
    hitBlinker();
    displayLife();
    if (xpos - size < 0) {
      leftSpeed = 0;
    }
    else {
      xpos -= leftSpeed * PApplet.parseFloat(millis() - ticksLastUpdate) * 0.001f;
    }
    if (xpos + size > width) {
      rightSpeed = 0;
    }
    else {
      xpos += rightSpeed * PApplet.parseFloat(millis() - ticksLastUpdate) * 0.001f;
    }
    if (ypos - size < 0) {
      upSpeed = 0;
    }
    else {
      ypos -= upSpeed * PApplet.parseFloat(millis() - ticksLastUpdate) * 0.001f;
    }
    if (ypos + size > height) {
      downSpeed = 0;
    }
    else {
      ypos += downSpeed * PApplet.parseFloat(millis() - ticksLastUpdate) * 0.001f;
    }
  }

  public void speedHandler() { //this handles acceleration and braking of speed for the movePlayer function
    if (left) {
      leftSpeed = constrain(leftSpeed, 0, maxSpeed) + speedModifier;
    } else if (!left) {
      leftSpeed = constrain(leftSpeed, brakeModifier, maxSpeed) - brakeModifier;
    }
    if (right) {
      rightSpeed = constrain(rightSpeed, 0, maxSpeed) + speedModifier;
    } else if (!right) {
      rightSpeed = constrain(rightSpeed, brakeModifier, maxSpeed) - brakeModifier;
    }
    if (up) {
      upSpeed = constrain(upSpeed, 0, maxSpeed) + speedModifier;
    } else if (!up) {
      upSpeed = constrain(upSpeed, brakeModifier, maxSpeed) - brakeModifier;
    }
    if (down) {
      downSpeed = constrain(downSpeed, 0, maxSpeed) + speedModifier;
    } else if (!down) {
      downSpeed = constrain(downSpeed, brakeModifier, maxSpeed) - brakeModifier;
    }
  }

  public void shootHandler() { //here, the shooting happens!
    if (shooting) {
      if (ticksElapsed > timeStamp + shootRateModifier) {
        bullets.add(new PlayerBullet(xpos, ypos));
        score--;
        timeStamp = ticksElapsed;
      }
    }
    for (int i = bullets.size() - 1; i >= 0; i--) {
      bullets.get(i).drawBullet();
      if (bullets.get(i).ypos < 0) {
        bullets.remove(i);
      }
    }
  }

  public void bulletCollision() { //collision is checked with each bullet from each enemy
    for (int k = enemyManager.bullets.size() - 1; k >= 0; k--) {
      if (enemyManager.bullets.get(k).xpos - enemyManager.bullets.get(k).size / 2 > xpos - size
       && enemyManager.bullets.get(k).xpos + enemyManager.bullets.get(k).size / 2 < xpos + size
       && enemyManager.bullets.get(k).ypos - enemyManager.bullets.get(k).size / 2 > ypos - size
       && enemyManager.bullets.get(k).ypos + enemyManager.bullets.get(k).size / 2 < ypos + size) {
         enemyManager.bullets.remove(k);
         hitBlinkOpacity = 255 / 2;
         if (!godmode) {
         health--;
       }
      }
    }
    for (int i = enemyManager.basicEnemies.size() - 1; i >= 0; i--) {
      for (int j = enemyManager.basicEnemies.get(i).bullets.size() - 1; j >= 0; j--) {
        if (enemyManager.basicEnemies.get(i).bullets.get(j).xpos - enemyManager.basicEnemies.get(i).bullets.get(j).size / 2 > xpos - size
         && enemyManager.basicEnemies.get(i).bullets.get(j).xpos + enemyManager.basicEnemies.get(i).bullets.get(j).size / 2 < xpos + size
         && enemyManager.basicEnemies.get(i).bullets.get(j).ypos - enemyManager.basicEnemies.get(i).bullets.get(j).size / 2 > ypos - size
         && enemyManager.basicEnemies.get(i).bullets.get(j).ypos + enemyManager.basicEnemies.get(i).bullets.get(j).size / 2 < ypos + size) {
           enemyManager.basicEnemies.get(i).bullets.remove(j);
           hitBlinkOpacity = 255 / 2;
           if (!godmode) {
           health--;
         }
        }
      }
    }
  }

  public void powerUpCollision() { //and here we check if the player has picked up some health
    for (int i = powerUpManager.powerUps.size() - 1; i >= 0; i--) {
      if (powerUpManager.powerUps.get(i).ypos > ypos - size
       && powerUpManager.powerUps.get(i).ypos < ypos + size
       && powerUpManager.powerUps.get(i).xpos > xpos - size
       && powerUpManager.powerUps.get(i).xpos < xpos + size) {
        if (health < maxHealth){
          health++;
            powerUpManager.powerUps.remove(i);
        }
      }
    }
  }


  public void hitBlinker() { //this flashes the screen when the player gets hit
    fill(218, 44, 56, hitBlinkOpacity);
    rectMode(CENTER);
    rect(width / 2, height / 2, width, height);
    if (hitBlinkOpacity > 0) {
      hitBlinkOpacity -= 5;
    }
  }

  public void displayLife() { //displays hearts in the lower right corner to show health left
    for (int i = 0; i <= health - 1; i++) {
      if (health >= 3) {
        if (millis() / 100 % 10 != 0) {
          image(heart, width - 40 - (i * 35), height - 40);
        }
      } else if (health == 2) {
        if (millis() / 100 % 5 != 0) {
          image(heart, width - 40 - (i * 35), height - 40);
        }
      } else {
        if (millis() / 100 % 2 != 0) {
          image(heart, width - 40 - (i * 35), height - 40);
        }
      }
    }
  }

  public void displayScore() { //displays score in bottom left corner
    fill(255);
    textSize(32);
    text(score, 80, height - 80);
  }

  public void displayCurrentLevel() { //displays current level in top left corner
    fill(255);
    textSize(24);
    textAlign(LEFT, CENTER);
    if (gamestate < 6) {
      text("LEVEL " + gamestate, 30, 40);
    } else {
      text("ENDLESS LEVEL", 200, 40);
    }
  }

  public void death() { //decides what happens when the player dies; depending on game mode (campaign or endless), it checks if the score is higher than the last entry on the list and sends you to either tag input or highscore screen
    switch (gamestate){
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        if(playerManager.score > highScoreList.get(9).points){  //checks if the player has set a new highscore better than the lowest one currently on the list
          menuIndex = 5;
        }
        else{
          menuIndex = 6;
        }
      break;
      case 6:
        if(playerManager.score > highScoreListEndless.get(9).points){  //checks if the player has set a new highscore better than the lowest one currently on the list
          menuIndex = 7;
        }
        else{
          menuIndex = 8;
        }
      break;
    }
    for (int i = enemyManager.basicEnemies.size() - 1; i >= 0; i--) {
      enemyManager.basicEnemies.remove(i);
    }
    for (int i = powerUpManager.powerUps.size() - 1; i >= 0; i--) {
      powerUpManager.powerUps.remove(i);
    }
  }
}
class PowerUp {
  PImage heart;
  float xpos, ypos, speed;

  PowerUp() {
    heart = loadImage("heart.png");
    xpos = random(50, width - 50);
    ypos = -100;
    speed = 75;
  }

  public void drawPowerUp() { //draws a heart at the powerup location
    move();
    imageMode(CENTER);
    image(heart, xpos, ypos);
  }

  public void move() { //moves the powerup downwards
    ypos += speed * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
  }
}
class PowerUpManager {
  ArrayList<PowerUp> powerUps;
  int timeStamp;

  PowerUpManager() {
    powerUps = new ArrayList<PowerUp>();
    timeStamp = 0;
  }

  public void powerUpSpawner() { //spawns powerups at regular intervals
    if (ticksElapsed > timeStamp + 400) {
      powerUps.add(new PowerUp());
      timeStamp = ticksElapsed;
    }

    for (int i = powerUps.size() - 1; i >= 0; i--) {
      powerUps.get(i).drawPowerUp();
    }
  }
}
class Score{ //simple score object for the highscore array lists
  int points;
  String tag;

  public @Override
  String toString(){
     return tag + ":" + points;
  }

  public int getPoints(){
    return points;
  }
}
class Star { //simple particles moving down to simulate wind
  float xpos, ypos, speed, size;

  Star() {
    resetStar();
  }

  public void resetStar() {
    xpos = random(width);
    ypos = 0 - size;
    speed = random(1, 40);
    size = speed / 1.5f;
  }

  public void drawStar() {
    stroke(255);
    line(xpos, ypos, xpos, ypos + size);
    }

    public void moveStar() {
      drawStar();
      if (ypos < height + size) {
        ypos += speed;
        } else {
          resetStar();
        }
    }
  }
  public void settings() {  size(800,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "toasterhell" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
