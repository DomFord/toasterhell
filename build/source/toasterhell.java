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
Star[] stars;
int gamestate;

public void setup() {
  
  background(0);
  gamestate = 1;

  levelManager = new LevelManager();
  playerManager = new PlayerManager();

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
          playerManager.movePlayer(0);
          break;
        case RIGHT:
          playerManager.movePlayer(1);
          break;
        case UP:
          playerManager.movePlayer(2);
          break;
        case DOWN:
          playerManager.movePlayer(3);
          break;
      }
      break;
  }
}

public void draw() {
levelManager.levelSelector();
playerManager.drawPlayer();

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
/*
This script handles the player, both what player is selected, player life, weapon, controls etc.
*/
class PlayerManager{
  float xpos, ypos, speed, size;
  boolean alive;

  PlayerManager() {
    alive = true;
    xpos = width / 2;
    ypos = height - 75;
    speed = 20;
    size = 50;
  }

  public void drawPlayer() {
    if (alive) {
      noFill();
      rectMode(CENTER);
      rect(xpos, ypos, size, size);
      } else {
        death();
      }
    }

    public void movePlayer(int direction) {
      switch (direction) {
        case 0:
          if (xpos - size > 0) {
            xpos -= speed;
        }
          break;
        case 1:
          if (xpos + size < width) {
            xpos += speed;
        }
          break;
        case 2:
          if (ypos - size > 0) {
            ypos -= speed;
        }
          break;
        case 3:
          if (ypos + size < height) {
            ypos += speed;
        }
          break;
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
