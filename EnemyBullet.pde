class EnemyBullet {
  float xpos, ypos, speed, size;
  boolean collided;

  EnemyBullet(float x, float y) {
    xpos = x;
    ypos = y;
    speed = 15;
    size = 3;
  }

  void drawBullet() {
    rectMode(CENTER);
    fill(218, 44, 56);
    stroke(218, 44, 56);
    rect(xpos, ypos, size, size * 5);
    ypos += speed;
  }
}
