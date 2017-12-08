import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.io.Serializable; 
import java.io.*; 
import java.util.Collections; 
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
HighscoreEntry highscoreEntry;
Highscores highscores;
ArrayList<PlayerManager> players;
ArrayList<Score> scores;
Star[] stars;
int gamestate, ticksElapsed, ticksLastUpdate;

public void setup() {
  
  background(0);
  gamestate = 1;
  ticksElapsed = 0;
  ticksLastUpdate = 0;

  levelManager = new LevelManager();
  playerManager = new PlayerManager();
  enemyManager = new EnemyManager();
  highscoreEntry = new HighscoreEntry();
  highscores = new Highscores();
  scores = FileManager.loadScore("memes.dat");

  stars = new Star[10];
  for (int i = 0; i < 10; i++) {
    stars[i] = new Star();
  }

}

public void keyPressed() {
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

public void keyReleased() {
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

public void draw() {
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
    break;
    case 6:
    case 7:
    levelManager.levelSelector();
    break;
}
}
class BasicEnemy {
  int timeStamp, shootRateModifier, shootCounter;
  float xpos, ypos, speed, size, leftSpeed, rightSpeed, upSpeed, downSpeed, speedModifier, brakeModifier;
  boolean alive, shooting;
  ArrayList<EnemyBullet> bullets;
  PImage enemyImage1;
  PImage enemyImage2;
  PImage enemyImage3;
  PImage enemyImage4;
  PImage enemyImage5;

  BasicEnemy() {
    shootCounter = 0;
    timeStamp = 0;
    shootRateModifier = 60;
    xpos = random(0 + size, width - size);
    ypos = -100;
    speed = 50;
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
  }

  public void drawEnemy() {
    if (alive) {
      move();
      bulletCollision();
      shootHandler();
      imageMode(CENTER);
      switch (gamestate){
        case 1:
        image(enemyImage1,xpos,ypos);
        break;
        case 2:
        image(enemyImage2,xpos,ypos);
        break;
        case 3:
        image(enemyImage3,xpos,ypos);
        break;
        case 4:
        image(enemyImage4,xpos,ypos);
        break;
        case 5:
        image(enemyImage5,xpos,ypos);
        break;
      }
      /*noFill();
      rectMode(CENTER);
      rect(xpos, ypos, size, size);*/

      } else {
        //death();
      }
    }

    public void move() {
      ypos += speed * PApplet.parseFloat(millis() - ticksLastUpdate)*0.001f;
    }

    public void bulletCollision() {
        for (int i = playerManager.bullets.size() - 1; i >= 0; i--) {
          if (playerManager.bullets.get(i).xpos - playerManager.bullets.get(i).size / 2 > xpos - size / 2
              && playerManager.bullets.get(i).xpos + playerManager.bullets.get(i).size / 2 < xpos + size / 2
              && playerManager.bullets.get(i).ypos - playerManager.bullets.get(i).size / 2 > ypos - size / 2
              && playerManager.bullets.get(i).ypos + playerManager.bullets.get(i).size / 2 < ypos + size / 2) {
                println("Enemy hit!");
                alive = false;
                playerManager.bullets.remove(i);
                playerManager.score += 10;
                println(playerManager.score);
              }
        }
    }

    public void shootHandler() {
      if (shooting) {
        switch (gamestate){
          case 1:
          shootRateModifier = 120;
          if (ticksElapsed > timeStamp + shootRateModifier) {
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
            timeStamp = ticksElapsed;
          }
          break;
          case 2:
          shootRateModifier = 200;
          if (ticksElapsed > timeStamp + shootRateModifier) {
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
            timeStamp = ticksElapsed;
          }
          break;
          case 3:
          if (shootCounter == 10){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 20){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 30){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 40){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 50){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 300){
            shootCounter = 0;
          }
          shootCounter ++;
          break;
          case 4:
          if (shootCounter == 20){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
          }
          if (shootCounter == 40){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
          }
          if (shootCounter == 60){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
          }
          if (shootCounter == 80){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
          }
          if (shootCounter == 100){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
          }
          if (shootCounter == 400){
            shootCounter = 0;
          }
          shootCounter ++;
          break;
          case 5:
          if (shootCounter == 10){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 20){
            bullets.add(new EnemyBullet(xpos, ypos, -100, 100));
          }
          if (shootCounter == 30){
            bullets.add(new EnemyBullet(xpos, ypos, -150, 00));
          }
          if (shootCounter == 40){
            bullets.add(new EnemyBullet(xpos, ypos, -100, -100));
          }
          if (shootCounter == 50){
            bullets.add(new EnemyBullet(xpos, ypos, 0, -150));
          }
          if (shootCounter == 60){
            bullets.add(new EnemyBullet(xpos, ypos, 100, -100));
          }
          if (shootCounter == 70){
            bullets.add(new EnemyBullet(xpos, ypos, 150, 0));
          }
          if (shootCounter == 80){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 100));
          }
          if (shootCounter == 90){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 300){
            shootCounter = 0;
          }
          shootCounter ++;
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

  public void drawBullet() {
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
  int timeStamp;

  EnemyManager() {
    basicEnemies = new ArrayList<BasicEnemy>();
    bullets = new ArrayList<EnemyBullet>();
    timeStamp = 0;
  }

  public void enemySpawner() {
    //switch case here to spawn the correct numbers and types of enemies per level
    enemyKiller();
    if (ticksElapsed > timeStamp + 100) {
      basicEnemies.add(new BasicEnemy());
      timeStamp = ticksElapsed;
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

  public void enemyKiller() {
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
      }
    }
  }
}
public static class FileManager {                                   // The class that will take care of saving and loading the highscores.

  public static void saveScore(String path, ArrayList<Score> data) { // Function to save the scores.
    try {
      FileOutputStream file = new FileOutputStream(path);            // Creating the file.
      ObjectOutputStream output = new ObjectOutputStream(file);
      output.writeObject(data);                                      // Writes the ArrayList to the file.
      output.close();                                                // Closes the file.
    }
    catch(Exception e) {
      e.printStackTrace();                                           // If it doesn't work, tell me why.
    }
  }

  public static ArrayList<Score> loadScore(String path) {       // Function to load the scores.
    File f = new File(path);

    if(f.exists() == false) {
      ArrayList<Score> newData = new ArrayList<Score>();
      saveScore(path, newData);
    }

    ArrayList<Score> data = null;

    try {
        FileInputStream file = new FileInputStream(path);       // Open up the file.
        ObjectInputStream input = new ObjectInputStream(file);
        Object result = input.readObject();                     // Create a result object containing the data of the file.
        input.close();                                          // Close the file.

        if(result instanceof ArrayList<?>) {
            data = (ArrayList<Score>)result;                    // Checks whether the data matches the ArrayList<Score> and, if it is, assigns it to the variable data.
        }
    }
    catch(EOFException eof) {
        System.out.println("File Ended Too Soon");
    }
    catch(Exception ex) {
        ex.printStackTrace();                                   // Again, if it doesn't work, tell me why.
    }

    return data;                                                // The data variable (our loaded ArrayList) is then returned by the load function.
  }
}
class HighscoreEntry {
  int letterSelect, letterRoll, lettersLocked, xpos, ypos;
  String a, blank, savedName;
  char[] alphabet, tag;

  HighscoreEntry() {
    a = "ABCDEFGHIJKLMNOPQRSTUVWXYX\u00c6\u00d8\u00c51234567890";
    blank = "   ";
    alphabet = a.toCharArray();
    tag = blank.toCharArray();
    letterSelect = 0;
    letterRoll = 0;
    lettersLocked = 0;
    xpos = width / 2;
    ypos = 400;
  }

  public void displayNameSelect() {
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);

    if (letterSelect <= 2) {
      text("ENTER YOUR NAME", width / 2, 200);
      } else {
        text("PRESS ENTER\n TO CONFIRM", width / 2, 200);
      }

      //letterSelectIndicator();

      letterSelect();

      String name = new String(tag);
      displayLockedLetters();
    }

    public void letterSelect() {
      switch (letterSelect) {
        case 0:
        text(alphabet[letterRoll], xpos - 50, ypos);
        break;
        case 1:
        text(alphabet[letterRoll], xpos, ypos);
        break;
        case 2:
        text(alphabet[letterRoll], xpos + 50, ypos);
        break;
      }
    }

    public void displayLockedLetters() {
      if (lettersLocked > 0) {              // If the number of letters locked is above 0, then the first locked character is displayed along with the rectangle indicator.
        text(tag[0], xpos - 50, ypos);
        rect(xpos - 53, ypos + 25, 50, 10);
      }

      if (lettersLocked > 1) {              // If it's above 1, then also show the second letter.
      text(tag[1], xpos, ypos);
      rect(xpos - 3, ypos + 25, 50, 10);
    }

    if (lettersLocked > 2) {             // And if it's above 2, display the final letter as well.
    text(tag[2], xpos + 50, ypos);
    rect(xpos + 47, ypos + 25, 50, 10);
  }
}

public void lockLetter(int letter) {
  tag[letterSelect] = alphabet[letter];
  lettersLocked++;
  letterSelect++;
  letterRoll = 0;
}

public void deleteLetter() {
  tag[letterSelect] = 32;
  lettersLocked--;
  letterSelect--;
}
/*
void letterSelectIndicator() {           // This function simply displays a flashing box to help indicate to the player which letter they're currently choosing.
rectMode(CENTER);                      // Draw these rectangles from the centre rather than top left.

if ( (millis() / 1000) % 2 == 0 ) {    // Using the same method of flashing as earlier to make the indicator blink.
stroke(scoreBoardCol);
fill(scoreBoardCol);
} else {
stroke(scoreBoardBGCol);
fill(scoreBoardBGCol);
}

switch (letterSelect) {               // Depending on which letter the player is selecting, the box will appear underneath it.
case 0:
rect(xpos - 53, ypos + 25, 50, 10);
break;
case 1:
rect(xpos - 3, ypos + 25, 50, 10);
break;
case 2:
rect(xpos + 47, ypos + 25, 50, 10);
break;
}
} */

public void setName() {                                // And finally we need to save the player's chosen name.
savedName = new String(tag);                  // Creates a new string from the tag character array.
scores.add(new Score(savedName, playerManager.score)); // Creates a new Score object to the scores ArrayList with the player's name and score.
FileManager.saveScore("memes.dat", scores);
scores = FileManager.loadScore("memes.dat");
Collections.sort(scores);
Collections.reverse(scores);
}
  }
class Highscores {
  int xpos, ypos;
  boolean printed;

  Highscores() {
    xpos = width / 2;
    ypos = 100;
    printed = false;
  }

  public void displayHighscores() {
    //fill(scoreboard.scoreBoardBGCol);
    background(255);
    textAlign(CENTER);
    text("HIGHSCORES", xpos, 50);

    FileManager.saveScore("memes.dat", scores);
    scores = FileManager.loadScore("memes.dat");
    Collections.sort(scores);
    //Collections.reverse(scores);

    for (int i = scores.size() - 1; i >= scores.size() - 11; i--) {
      textAlign(LEFT);
      text(scores.get(i).playerName(), 100, height + 100 - (i * 30));
      textAlign(RIGHT);
      text(scores.get(i).playerScore(), width - 100, height + 100 - (i * 30));
    }
    if (!printed) {
      println("HIGHSCORES: ");
      for (int i = 0; i < scores.size(); i++) {
        println("Score " + i + ": " + scores.get(i).playerName() + " " + scores.get(i).playerScore() + ".");
      }
      printed = true;
  }
}
}
/*
This script deals with levels; it handles what level is selected and how each level plays out etc.
*/
class LevelManager{
  int bgColour;
  int backgroundyPos;
  PImage backgroundGrass;
  PImage backgroundWater;
  PImage backgroundRock;
  PImage backgroundIce;
  PImage backgroundLava;

  LevelManager() {
    backgroundyPos = 0;
    backgroundGrass = loadImage("grass.png");
    backgroundWater = loadImage("water.png");
    backgroundRock = loadImage("rocks.png");
    backgroundIce = loadImage("ice.png");
    backgroundLava = loadImage("lava.png");
    backgroundGrass.resize(width,0);
    backgroundWater.resize(width,0);
    backgroundRock.resize(width,0);
    backgroundIce.resize(width,0);
    backgroundLava.resize(width,0);
  }

  public void levelSelector() {
    switch (gamestate) {
      case 1:
        image(backgroundGrass,width/2,backgroundyPos);
        image(backgroundGrass,width/2,(backgroundyPos-backgroundGrass.height));
        backgroundyPos++;
        if(backgroundyPos >= backgroundGrass.height){
          backgroundyPos = 0;
        }
        spaceLevel();
      break;
      case 2:
        image(backgroundWater,width/2,backgroundyPos);
        image(backgroundWater,width/2,(backgroundyPos-backgroundWater.height));
        backgroundyPos++;
        if(backgroundyPos >= backgroundWater.height){
          backgroundyPos = 0;
        }
        spaceLevel();
      break;
      case 3:
        image(backgroundRock,width/2,backgroundyPos);
        image(backgroundRock,width/2,(backgroundyPos-backgroundRock.height));
        backgroundyPos++;
        if(backgroundyPos >= backgroundRock.height){
          backgroundyPos = 0;
        }
        spaceLevel();
      break;
      case 4:
        image(backgroundIce,width/2,backgroundyPos);
        image(backgroundIce,width/2,(backgroundyPos-backgroundIce.height));
        backgroundyPos++;
        if(backgroundyPos >= backgroundIce.height){
          backgroundyPos = 0;
        }
        spaceLevel();
      break;
      case 5:
        image(backgroundLava,width/2,backgroundyPos);
        image(backgroundLava,width/2,(backgroundyPos-backgroundLava.height));
        backgroundyPos++;
        if(backgroundyPos >= backgroundLava.height){
          backgroundyPos = 0;
        }
        spaceLevel();
      break;
      case 6:
        highscoreEntry.displayNameSelect();
      break;
      case 7:
        highscores.displayHighscores();
      break;
    }
  }

  public void spaceLevel() {
    for (int i = 0; i < stars.length; i++) {
      stars[i].moveStar();
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

  public void drawBullet() {
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
  int timeStamp, shootRateModifier, playerSelect, avatarFrame, ticksLast, frameDuration, score, health;
  float xpos, ypos, maxSpeed, size, leftSpeed, rightSpeed, upSpeed, downSpeed, speedModifier, brakeModifier, hitBlinkOpacity;
  boolean alive, left, right, up, down, shooting;
  ArrayList<PlayerBullet> bullets;
  PImage player1sheet;
  PImage player2sheet;
  PImage heart;

  PlayerManager() {
    timeStamp = 0;
    shootRateModifier = 10;
    alive = true;
    xpos = width / 2;
    ypos = height - 75;
    maxSpeed = 400;
    size = 50;
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
  }

  public void drawPlayer() {
    if (alive) {
      speedHandler();
      movePlayer();
      shootHandler();
      displayScore();

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
      else if (playerSelect == 2){
        PImage f = player2sheet.get((avatarFrame*60),0,60,66);
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
      /*noFill();
      rectMode(CENTER);
      rect(xpos, ypos, size, size);
      movePlayer();
      shoot();*/

      } else {
        death();
      }
    }

    public void movePlayer() {
      speedHandler();
      shootHandler();
      bulletCollision();
      hitBlinker();
      displayLife();
      if (xpos - size < 10) {
        leftSpeed = 0;
      }
      else {
        xpos -= leftSpeed * PApplet.parseFloat(millis() - ticksLastUpdate) * 0.001f;
      }
      if (xpos + size > width - 10) {
        rightSpeed = 0;
      }
      else {
        xpos += rightSpeed * PApplet.parseFloat(millis() - ticksLastUpdate) * 0.001f;
      }
      if (ypos - size < 10) {
        upSpeed = 0;
      }
      else {
        ypos -= upSpeed * PApplet.parseFloat(millis() - ticksLastUpdate) * 0.001f;
      }
      if (ypos + size > height - 10) {
        downSpeed = 0;
      }
      else {
        ypos += downSpeed * PApplet.parseFloat(millis() - ticksLastUpdate) * 0.001f;
      }
    }

    public void speedHandler() {
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

    public void speedDebug() {
      if (millis() / 1000 % 2 == 0) {
        println("Left: " + leftSpeed);
        println("Right: " + rightSpeed);
        println("Up: " + upSpeed);
        println("Down: " + downSpeed);
      }
    }

    public void shootHandler() {
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

  public void bulletCollision() {
    for (int k = enemyManager.bullets.size() - 1; k >= 0; k--) {
      if (enemyManager.bullets.get(k).xpos - enemyManager.bullets.get(k).size / 2 > xpos - size / 2
          && enemyManager.bullets.get(k).xpos + enemyManager.bullets.get(k).size / 2 < xpos + size / 2
          && enemyManager.bullets.get(k).ypos - enemyManager.bullets.get(k).size / 2 > ypos - size / 2
          && enemyManager.bullets.get(k).ypos + enemyManager.bullets.get(k).size / 2 < ypos + size / 2) {
            println("Player hit!");
            enemyManager.bullets.remove(k);
            hitBlinkOpacity = 255 / 2;
            health--;
            println(health);
        }
      }
    for (int i = enemyManager.basicEnemies.size() - 1; i >= 0; i--) {
      for (int j = enemyManager.basicEnemies.get(i).bullets.size() - 1; j >= 0; j--) {
        if (enemyManager.basicEnemies.get(i).bullets.get(j).xpos - enemyManager.basicEnemies.get(i).bullets.get(j).size / 2 > xpos - size / 2
            && enemyManager.basicEnemies.get(i).bullets.get(j).xpos + enemyManager.basicEnemies.get(i).bullets.get(j).size / 2 < xpos + size / 2
            && enemyManager.basicEnemies.get(i).bullets.get(j).ypos - enemyManager.basicEnemies.get(i).bullets.get(j).size / 2 > ypos - size / 2
            && enemyManager.basicEnemies.get(i).bullets.get(j).ypos + enemyManager.basicEnemies.get(i).bullets.get(j).size / 2 < ypos + size / 2) {
              println("Player hit!");
              enemyManager.basicEnemies.get(i).bullets.remove(j);
              hitBlinkOpacity = 255 / 2;
              health--;
              println(health);
          }
        }
      }
  }

  public void hitBlinker() {
    fill(218, 44, 56, hitBlinkOpacity);
    rectMode(CENTER);
    rect(width / 2, height / 2, width, height);
    if (hitBlinkOpacity > 0) {
      hitBlinkOpacity -= 5;
    }
  }

  public void displayLife() {
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

  public void displayScore() {
    fill(0);
    textSize(32);
    text(score, 40, height - 40);
  }

    public void death() {

    }

  }
class Star {
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
