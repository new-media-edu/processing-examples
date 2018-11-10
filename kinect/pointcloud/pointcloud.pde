import controlP5.*; //<>//
ControlP5 cp5;

import org.openkinect.processing.*;
import java.nio.FloatBuffer;

// Kinect Library object
Kinect2 kinect2;

// Angle for rotation
float a = 3.1; // 3.1

int vertLoc;

int minDepth = 200;
int maxDepth = 1000;
int skip = 4;

float lerpSpeed = .001;
float chance = .01;
float particleSize = 4;

ArrayList<Star> stars = new ArrayList(4000);

PGraphics pg;
boolean RECORDING = false;

void setup() {

  // Rendering in P3D
  //size(800, 600, P3D);
  fullScreen(P3D);

  pg = createGraphics(width, height, P3D);

  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();

  //smooth(16);

  pg.beginDraw();
  pg.background(0);
  pg.endDraw();

  setupControls();
}


void draw() {
  pg.beginDraw();
  pg.background(0);

  // Translate and rotate
  pg.pushMatrix();
  pg.translate(width/2, height/2, 600);

  pg.rotateY(a);

  // Get the raw depth as array of integers
  int[] depth = kinect2.getRawDepth();

  pg.stroke(255);
  for (int x = 0; x < kinect2.depthWidth; x+=skip) {
    for (int y = 0; y < kinect2.depthHeight; y+=skip) {
      int offset = x + y * kinect2.depthWidth;

      if (depth[offset] > minDepth && depth[offset] < maxDepth) {

        //calculte the x, y, z camera position based on the depth information
        PVector point = depthToPointCloudPos(x, y, depth[offset]);

        //stroke(map(depth[offset], minDepth, maxDepth, 255, 0));

        // Draw a point
        //vertex(point.x, point.y, point.z);

        if (random(1)>(1-chance))
          stars.add(new Star(point));
      }
    }
  }

  pg.popMatrix();

  pg.pushMatrix();
  pg.translate(width/2, height/2, 600);

  pg.rotateY(a);

  pg.stroke(255);

  for (int i = stars.size() - 1; i >= 0; i--) {
    Star s = stars.get(i);

    if (s.isDead()) {
      stars.remove(i);
    } else {
      s.update();
      s.display();
    }
  }

  pg.popMatrix();
  pg.endDraw();

  image(pg, 0, 0);

  if (RECORDING) {
    save("out/" + nfs(frameCount, 4) + "-x.jpg");
    pushStyle();
    colorMode(RGB, 255);
    fill(255, 0, 0);
    pushMatrix();
    ellipse(100, 100, 100, 100);
    popMatrix();
    popStyle();
  }

  // Rotate
  //a += 0.0015f;
}


void keyPressed() {
  if (key=='s') cp5.saveProperties();
  if (key=='l') cp5.loadProperties();
  if (key=='r') {
    for (int i = stars.size() - 1; i >= 0; i--) {
      stars.remove(i);
    }
  }
  if (key=='1') RECORDING = true;
  if (key=='2') RECORDING = false;
}

//calculate the xyz camera position based on the depth data
PVector depthToPointCloudPos(int x, int y, float depthValue) {
  PVector point = new PVector();
  point.z = (depthValue);// / (1.0f); // Convert from mm to meters
  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx;
  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;
  return point;
}