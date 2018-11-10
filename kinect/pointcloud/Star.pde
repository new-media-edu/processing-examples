class Star {
  PVector p;  // position, destination

  float life = 1;
  float decay = .01;

  color c;

  float phase = 0;
  
  PVector rot;

  Star(PVector p) {
    this.p = new PVector(p.x, p.y, p.z);

    colorMode(HSB, 360, 255, 255);
    c = color(random(200, 280), random(200, 255), 255);
    
    // random starting rotation
    rot = new PVector(random(TWO_PI),random(TWO_PI),random(TWO_PI));;

    // should this one not die?
    if (random(1)>1-chance) {
      decay = 0;
    }
  }

  void update() {
    if(p.y < height/2)
    p.y += lerpSpeed;
    
    // rotation
    rot.x += .01;
    rot.y += .01;
    rot.z += .01;

    life -= decay;
  }

  void display() {
    //pg.strokeWeight(particleSize);
    //pg.stroke(c, life*255);
    //pg.point(p.x, p.y, p.z);
    pg.pushMatrix();
    pg.fill(c, life*255);
    pg.noStroke();
    pg.translate(p.x, p.y, p.z);
    pg.rotateX(rot.x);
    pg.rotateY(rot.y);
    pg.rotateZ(rot.z);
    pg.box(particleSize);
    pg.popMatrix();
  }

  boolean isDead() {
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
}