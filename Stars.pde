class Star { //simple particles moving down to simulate wind
  float xpos, ypos, speed, size;

  Star() {
    resetStar();
  }

  void resetStar() {
    xpos = random(width);
    ypos = 0 - size;
    speed = random(1, 40);
    size = speed / 1.5;
  }

  void drawStar() {
    stroke(255);
    line(xpos, ypos, xpos, ypos + size);
    }

    void moveStar() {
      drawStar();
      if (ypos < height + size) {
        ypos += speed;
        } else {
          resetStar();
        }
    }
  }
