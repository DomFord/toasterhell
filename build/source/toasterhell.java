import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

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

LevelManager levelManager;
PlayerManager playerManager;
EnemyManager enemyManager;
Star[] stars;
int gamestate, ticksElapsed;

public void setup() {
  
  background(0);
  gamestate = 1;
  ticksElapsed = 0;

  levelManager = new LevelManager();
  playerManager = new PlayerManager();
  enemyManager = new EnemyManager();

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
  }

  switch (gamestate) {
    case 1:
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

public void keyReleased() {
  switch (gamestate) {
    case 1:
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
levelManager.levelSelector();
playerManager.drawPlayer();
enemyManager.enemySpawner();
ticksElapsed++;

  switch (gamestate) {
    case 1 :
      break;
    case 2 :
      break;
    case 3 :
      break;
    case 4 :
      break;
  }
}
class BasicEnemy {
  int timeStamp, shootRateModifier;
  float xpos, ypos, speed, size, leftSpeed, rightSpeed, upSpeed, downSpeed, speedModifier, brakeModifier;
  boolean alive, shooting;
  //ArrayList<Enemy> bullets;

  BasicEnemy() {
    timeStamp = 0;
    shootRateModifier = 0;
    xpos = random(0 + size, width - size);
    ypos = -100;
    speed = 5;
    size = 50;
    leftSpeed = 0;
    rightSpeed = 0;
    upSpeed = 0;
    downSpeed = 0;
    speedModifier = 0.2f;
    brakeModifier = 0.5f;
    alive = true;
    shooting = false;
    //bullets = new ArrayList<EnemyBullet>;
  }

  public void drawEnemy() {
    if (alive) {
      noFill();
      rectMode(CENTER);
      rect(xpos, ypos, size, size);
      move();
      bulletCollision();
      } else {
        //death();
      }
    }

    public void move() {
      ypos += speed;
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
              }
        }
    }
}
class EnemyManager {
  ArrayList<BasicEnemy> basicEnemies;
  int timeStamp;

  EnemyManager() {
    basicEnemies = new ArrayList<BasicEnemy>();
    timeStamp = 0;
  }

  public void enemySpawner() {
    //switch case here to spawn the correct numbers and types of enemies per level
    enemyKiller();
    switch (gamestate) {
      case 1:
        if (ticksElapsed > timeStamp + 100) {
          basicEnemies.add(new BasicEnemy());
          timeStamp = ticksElapsed;
      }
        for (int i = basicEnemies.size() - 1; i >= 0; i--) {
          basicEnemies.get(i).drawEnemy();
          }
        break;
    }
  }

  public void enemyKiller() {
    for (int i = basicEnemies.size() - 1; i >= 0; i--) {
      if (!basicEnemies.get(i).alive) {
        basicEnemies.remove(i);
      }
    }
  }
}
/*
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
*/
/*
This script deals with levels; it handles what level is selected and how each level plays out etc.
*/
class LevelManager{
  int bgColour;

  LevelManager() {
  }

  public void levelSelector() {
    switch (gamestate) {
      case 1:
        bgColour = color(12, 23, 45);
        spaceLevel();
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
    }
  }

  public void spaceLevel() {
    background(bgColour);
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
    speed = 15;
    size = 3;
  }

  public void drawBullet() {
    rectMode(CENTER);
    fill(255);
    stroke(255);
    rect(xpos, ypos, size, size * 5);

    if (!collided) {
      ypos -= speed;
    }
  }
}
/*
This script handles the player, both what player is selected, player life, weapon, controls etc.
*/
class PlayerManager{
  int timeStamp, shootRateModifier, playerSelect, avatarFrame, ticksLast, frameDuration;
  float xpos, ypos, maxSpeed, size, leftSpeed, rightSpeed, upSpeed, downSpeed, speedModifier, brakeModifier;
  boolean alive, left, right, up, down, shooting;
  ArrayList<PlayerBullet> bullets;
  PImage player1sheet;
  PImage player2sheet;

  PlayerManager() {
    timeStamp = 0;
    shootRateModifier = 10;
    alive = true;
    xpos = width / 2;
    ypos = height - 75;
    maxSpeed = 10;
    size = 50;
    left = false;
    right = false;
    up = false;
    down = false;
    shooting = false;
    leftSpeed = constrain(leftSpeed, 0, maxSpeed);
    rightSpeed = constrain(rightSpeed, 0, maxSpeed);
    upSpeed = constrain(upSpeed, 0, maxSpeed);
    downSpeed = constrain(downSpeed, 0, maxSpeed);
    speedModifier = 0.2f;
    brakeModifier = 0.5f;
    bullets = new ArrayList<PlayerBullet>();
    player1sheet = loadImage("player_avatar_1.png");
    player2sheet = loadImage("player_avatar_2.png");
    playerSelect = 1;
    avatarFrame = 0;
    ticksLast = millis();
    frameDuration = 100;
  }

  public void drawPlayer() {
    if (alive) {
      speedHandler();
      movePlayer();
      shootHandler();
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
      if (xpos - size < 10) {
        leftSpeed = 0;
      }
      else {
        xpos -= leftSpeed;
      }
      if (xpos + size > width - 10) {
        rightSpeed = 0;
      }
      else {
        xpos += rightSpeed;
      }
      if (ypos - size < 10) {
        upSpeed = 0;
      }
      else {
        ypos -= upSpeed;
      }
      if (ypos + size > height - 10) {
        downSpeed = 0;
      }
      else {
        ypos += downSpeed;
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
