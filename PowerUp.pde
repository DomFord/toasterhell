class PowerUp {
  PImage heart;
  float xpos, ypos, speed;

  PowerUp() {
    heart = loadImage("heart.png");
    xpos = random(50, width - 50);
    ypos = -100;
    speed = 75;
  }

  void drawPowerUp() { //draws a heart at the powerup location
    move();
    imageMode(CENTER);
    image(heart, xpos, ypos);
  }

  void move() { //moves the powerup downwards
    ypos += speed * float(millis() - ticksLastUpdate)*0.001;
  }
}
