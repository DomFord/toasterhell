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

  void drawPlayer() {
    if (alive) {
      noFill();
      rectMode(CENTER);
      rect(xpos, ypos, size, size);
      } else {
        death();
      }
    }

    void movePlayer(int direction) {
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

    void death() {
    }

  }
