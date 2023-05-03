import ddf.minim.*;

AudioPlayer tiro, gameover, boom, tema, vida, perde;
Minim minim;

Tiros[] tiros = new Tiros[1];
PFont fonte;
PImage fundo, play, playover, meteoro, nave, over, score, again, againover, exit, exitover, corac, laser, kit, escudo, escudobarra, powerup;
float gravity = 0.1;
int xnave;
int xn = constrain(xnave, 400, 600);
int speed;
int yinimigos = 1;
float pont = 0;
int xinimigos = 200;
boolean menu = true;
int xmeteoro1, xmeteoro2, xmeteoro3, xmeteoro4;
int ymeteoro1, ymeteoro2, ymeteoro3, ymeteoro4;
int fade1, fade;
int ycura, xcura;
int yescudo, xescudo;
int armadura;
int vidas = 3;
boolean hit = false;
void setup() {
  size(400, 600);
  // Initialize ball index 0
  tiros[0] = new Tiros(0, 0, 0);

  cursor(0); 
  frameRate(60);

  xmeteoro1 = (int) random(15, 100);
  xmeteoro2 = (int) random(115, 200);
  xmeteoro3 = (int) random(215, 300);
  xmeteoro4 = (int) random(315, 400);
  ymeteoro1 = -((int) random(15, 500));
  ymeteoro2 = -((int) random(15, 500));
  ymeteoro3 = -((int) random(15, 500));
  ymeteoro4 = -((int) random(15, 500));

  xcura = (int) random(40, 360);
  ycura = -((int) random(500, 2000));

  xescudo = (int) random(40, 360);
  yescudo = -((int) random(2000, 4000));

  menu = true;

  fundo = loadImage("fundo.png");
  play = loadImage("play.png");
  playover = loadImage("playover.png");
  meteoro = loadImage("meteoro.png");
  nave = loadImage("nave.png");
  over = loadImage("over.png");
  score = loadImage("score.png");
  again = loadImage("againover.png");
  againover = loadImage("again.png");
  corac = loadImage("corac.png");
  exit = loadImage("exit.png");
  exitover = loadImage("exitover.png");
  fonte = loadFont("OCRAExtended-30.vlw");
  laser = loadImage("laserGreen10.png");
  kit = loadImage("kit.png");
  escudo = loadImage("escudo.png");

  escudobarra = loadImage("escudobarra.png");
  powerup = loadImage("powerescudo.png");

  minim = new Minim(this);
  tiro = minim.loadFile("tiro.mp3");
  gameover = minim.loadFile("gameover.mp3");
  boom = minim.loadFile("explosion.mp3");
  tema = minim.loadFile("tema.mp3");
  vida = minim.loadFile("vida.mp3");
  perde = minim.loadFile("perdeu.mp3");
}

void draw() {
  background(100);
  if (menu == true) {
    background(0);
    image(play, 150, 150);
    image(exitover, 150, 400);
    if (fade1 >= 1) {
      fade = fade - 5;
      tint(fade, fade, fade);
      if (fade <= -200) {
        menu = false;                         
        noTint();
        fade1 = 0;
      }
    }

    if (mouseX >= 150 && mouseX <= 250 && mouseY >= 400 && mouseY <= 500) {
      image(exit, 150, 400);
      if (mousePressed) {
        exit();
      }
    }

    if (mouseX >= 150 && mouseX <= 250 && mouseY >= 150 && mouseY <= 250) {
      image(playover, 150, 150);
      if (mousePressed) {
        fade1 = 1;
      }
    }
  }
  if (menu == false) {
    image(fundo, 0, -280);
    // Update and display all balls
    tema.play();
    for (int i = 0; i < tiros.length; i++) {
      tiros[i].gravity();
      tiros[i].move();
      tiros[i].display();
      tiros[i].onhit();
    }


    //MOVIMENTOS NAVE
    rectMode(CENTER);
    image(nave, xnave-40, 530);
    //rect(xnave, 570, 50, 30);
    if (keyPressed) {
      if (keyCode == LEFT) {
        xnave -= 10;
      }
      if (keyCode == RIGHT) {
        xnave += 10;
      }
      if (keyCode == BACKSPACE) {
        Tiros t = new Tiros(xnave, 550, 10);
        tiros = (Tiros[]) append(tiros, t);
      }
    }

    // FIM MOVIMENTOS NAVE
    ymeteoro1 += 1*pont/50;
    ymeteoro2 += 1*pont/50;
    ymeteoro3 += 1*pont/50;
    ymeteoro4 += 1*pont/50;
    ycura = ycura + 3;
    yescudo = yescudo + 3;

    if (pont >= 500) {
      ymeteoro1++;
      ymeteoro2++;
      ymeteoro3++;
      ymeteoro4++;
    }

    if (vidas > 0) {
      pont = pont + 0.25;
    }

    //rect(xmeteoro1, ymeteoro1, 30, 30);
    image(meteoro, xmeteoro1-22, ymeteoro1-45);
    image(meteoro, xmeteoro2-22, ymeteoro2-45);
    image(meteoro, xmeteoro3-22, ymeteoro3-45);
    image(meteoro, xmeteoro4-22, ymeteoro4-45);
    image(kit, xcura-20, ycura-20);
    image(powerup, xescudo-15, yescudo-15);

    fill(159, 95, 159);
    rect(200, 0, 400, 60);
    textSize(30);
    fill(255);
    textFont(fonte);
    text(int(pont), 30, 25);

    if (vidas == 3) {
      image(corac, 300, 0);
      image(corac, 330, 0);
      image(corac, 360, 0);
    } else if (vidas == 2) {
      image(corac, 300, 0);
      image(corac, 330, 0);
    } else if (vidas == 1) {
      image(corac, 300, 0);
    }

    if (armadura == 3) {
      image(escudobarra, 170, 0);
      image(escudobarra, 200, 0);
      image(escudobarra, 230, 0);
    } else if (armadura == 2) {
      image(escudobarra, 170, 0);
      image(escudobarra, 200, 0);
    } else if (armadura == 1) {
      image(escudobarra, 170, 0);
    }

    if (armadura <0) {
      armadura = 0;
    }

    if (ymeteoro1>=600) {
      xmeteoro1 = (int) random(15, 100);
      ymeteoro1 = -((int) random(15, 500));
    }

    if (ymeteoro2>=600) {
      xmeteoro2 = (int) random(115, 200);
      ymeteoro2 = -((int) random(15, 500));
    }

    if (ymeteoro3>=600) {
      xmeteoro3 = (int) random(215, 300);
      ymeteoro3 = -((int) random(15, 500));
    }

    if (ymeteoro4>=600) {
      xmeteoro4 = (int) random(315, 400);
      ymeteoro4 = -((int) random(15, 500));
    }

    if (ycura>=600) {
      xcura = (int) random(40, 360);
      ycura = -((int) random(500, 2000));
    }

    if (yescudo>=600) {
      xescudo = (int) random(40, 360);
      yescudo = -((int) random(1000, 2000));
    }


    if (xnave <= xcura+20 && xnave>= xcura-20 && ycura>=530) {
      xcura = (int) random(40, 360);
      ycura = -((int) random(500, 2000));
      vida.play();
      vida.rewind();
      if (vidas < 3) {
        vidas++;
        vida.play();
        vida.rewind();
      }
    }

    if (xnave <= xescudo+15 && xnave>= xescudo-15 && yescudo>=530) {
      xescudo = (int) random(40, 360);
      yescudo = -((int) random(2000, 4000));
      vida.play();
      vida.rewind();
      print(armadura);
      if (armadura < 3) {
        armadura = 3;
        vida.play();
        vida.rewind();
      }
    }

    // Verifica se algum objeto bateu na nave e retira uma vida
    if (xnave <= xmeteoro1+25 && xnave >= xmeteoro1-25 && ymeteoro1>=530) {
      xmeteoro1 = (int) random(15, 100);
      ymeteoro1 = -((int) random(15, 500));
      armadura--;
      perde.play();
      perde.rewind();
      if (armadura < 0) {
        vidas--;
        perde.play();
        perde.rewind();
      }
    }
    if (xnave <= xmeteoro2+25 && xnave >= xmeteoro2-25 && ymeteoro2>=530) {
      xmeteoro2 = (int) random(15, 100);
      ymeteoro2 = -((int) random(15, 500));
      armadura--;
      perde.play();
      perde.rewind();
      if (armadura < 0) {
        vidas--;
        perde.play();
        perde.rewind();
      }
    }
    if (xnave <= xmeteoro3+25 && xnave >= xmeteoro3-25 && ymeteoro3>=530) {
      xmeteoro3 = (int) random(15, 100);
      ymeteoro3 = -((int) random(15, 500));
      armadura--;
      perde.play();
      perde.rewind();
      if (armadura < 0) {
        vidas--;
        perde.play();
        perde.rewind();
      }
    }

    if (xnave <= xmeteoro4+25 && xnave >= xmeteoro4-25 && ymeteoro4>=530) {
      xmeteoro4 = (int) random(15, 100);
      ymeteoro4 = -((int) random(15, 500));
      armadura--;
      perde.play();
      perde.rewind();
      if (armadura < 0) {
        vidas--;
        perde.play();
        perde.rewind();
      }
    }

    if (armadura > 0){
      image(escudo,xnave-35,520);
    }


      // FIM verificação 

      // GAMEOVER
      if (vidas <= 0) {

      tema.pause();
      tema.rewind();

      gameover.play();
      background(0);
      image(over, 0, -25);
      fill(255);
      textSize(30);
      textFont(fonte);
      image(score, 130, 200);
      text(pont, 130, 260);
      image(againover, 75, 400);
      image(exitover, 200, 400);

      xmeteoro1 = 0;
      xmeteoro2 = 0;
      xmeteoro3 = 0;
      xmeteoro4 = 0;
      ymeteoro1 = 0;
      ymeteoro2 = 0;
      ymeteoro3 = 0;
      ymeteoro4 = 0;
      xcura = 0;
      ycura = 0;
      xescudo = 0;
      yescudo = 0;
      armadura = 0;

      if (mouseX >= 75 && mouseX<= 175 && mouseY >= 400 && mouseY <=500) {
        image(again, 75, 400);
        if (mousePressed) {
          xnave = 200;
          pont = 0;
          menu = false;
          xmeteoro1 = (int) random(15, 100);
          xmeteoro2 = (int) random(115, 200);
          xmeteoro3 = (int) random(215, 300);
          xmeteoro4 = (int) random(315, 400);
          ymeteoro1 = -((int) random(15, 500));
          ymeteoro2 = -((int) random(15, 500));
          ymeteoro3 = -((int) random(15, 500));
          ymeteoro4 = -((int) random(15, 500));

          xcura = (int) random(40, 360);
          ycura = -((int) random(500, 2000));

          xescudo = (int) random(40, 360);
          yescudo = -((int) random(2000, 4000));

          armadura = 0;
          vidas = 3;
        }
      }
      if (mouseX >= 200 && mouseX<= 300 && mouseY >= 400 && mouseY <=500) {
        image(exit, 200, 400);
        if (mousePressed) {
          exit();
        }
      }
    }
    // Troca a nave de lugar 

    if (xnave > width) {
      xnave = 0;
    } else if (xnave < 0) {
      xnave = width;
    }


    // FIM da troca de lugar 
    //
  }
}

void keyPressed() {
  // A new ball object
  switch(key) {
  case ' ':
    tiro.play();
    Tiros a = new Tiros(xnave-25, 550, 10);
    Tiros b = new Tiros(xnave+23, 550, 10);
    tiros = (Tiros[]) append(tiros, a);
    tiros = (Tiros[]) append(tiros, b);
    tiro.rewind();
  }
}
