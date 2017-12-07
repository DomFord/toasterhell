/*
This script handles the player, both what player is selected, player life, weapon, controls etc.
*/
class PlayerManager{
  int timeStamp;
  float xpos, ypos, maxSpeed, size, leftSpeed, rightSpeed, upSpeed, downSpeed, speedModifier, brakeModifier;
  boolean alive, left, right, up, down, shooting;
  ArrayList<PlayerBullet> bullets;

  PlayerManager() {
    timeStamp = 0;
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
    speedModifier = 0.2;
    brakeModifier = 0.5;
    bullets = new ArrayList<PlayerBullet>();
  }

  void drawPlayer() {
    if (alive) {
      noFill();
      rectMode(CENTER);
      rect(xpos, ypos, size, size);
      speedHandler();
      speedDebug();
      movePlayer();
      shoot();
      } else {
        death();
      }
    }

    void movePlayer() {
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

    void speedHandler() {
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

    void speedDebug() {
      if (millis() / 1000 % 2 == 0) {
        println("Left: " + leftSpeed);
        println("Right: " + rightSpeed);
        println("Up: " + upSpeed);
        println("Down: " + downSpeed);
      }
    }

    void shoot() {
      if (shooting) {
        if (ticksElapsed > timeStamp + 10) {
          bullets.add(new PlayerBullet(xpos, ypos));
          timeStamp = ticksElapsed;
        }
      }
      for (int i = bullets.size() - 1; i >= 0; i--) {
        bullets.get(i).drawBullet();
    }
  }

    void death() {
    }

  }
