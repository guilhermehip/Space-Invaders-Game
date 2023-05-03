class Tiros {
  float x;
  float y;
  float speed;
  float w;

  Tiros(float tempX, float tempY, float tempW) {
    x = tempX;
    y = tempY;
    w = tempW;
    speed = 0;
  }

  void gravity() {
    speed = speed + 1;
  }

  void move() {
    // Add speed to y location
    y = y - speed;
    // If square reaches the bottom
    // Reverse speed
    if (y > height) {
      speed = speed * 0.95;
      y = height;
    }

    if (y < 30) {
      x = 10000;
    }
  }

  void display() {
    // Display the circle
    fill(255);
    noStroke();
    image(laser, x-5, y-5);
  }

  void onhit() {
    if (y <= ymeteoro1 && x <= xmeteoro1+15 && x >= xmeteoro1-15) {
      xmeteoro1 = (int) random(15, 100);
      ymeteoro1 = -((int) random(15, 500));
      x = 10000;
      boom.play();
      boom.rewind();
    }
    if (y <= ymeteoro2 && x <= xmeteoro2+15 && x >= xmeteoro2-15) {
      xmeteoro2 = (int) random(115, 200);
      ymeteoro2 = -((int) random(15, 500));
      x = 10000;
      boom.play();
      boom.rewind();
    }
    if (y <= ymeteoro3 && x <= xmeteoro3+15 && x >= xmeteoro3-15) {
      xmeteoro3 = (int) random(215, 300);
      ymeteoro3 = -((int) random(15, 500));
      x = 10000;
      boom.play();
      boom.rewind();
    }
    if (y <= ymeteoro4 && x <= xmeteoro4+15 && x >= xmeteoro4-15) {
      xmeteoro4 = (int) random(315, 400);
      ymeteoro4 = -((int) random(15, 500));
      x = 10000;
      boom.play();
      boom.rewind();
    }
  }
}
