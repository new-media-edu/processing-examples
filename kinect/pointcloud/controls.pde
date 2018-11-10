void setupControls() {
  cp5 = new ControlP5(this);
  //cp5.loadProperties();

  cp5.addSlider("minDepth")
    .setPosition(10, 10)
    .setRange(0, 5000)
    ;

  cp5.addSlider("maxDepth")
    .setPosition(10, 30)
    .setRange(0, 5000)
    ;

  cp5.addSlider("skip")
    .setPosition(10, 50)
    .setRange(1, 12)
    ;

  cp5.addSlider("lerpSpeed")
    .setPosition(10, 70)
    .setRange(0.0, 10.0)
    ;

  cp5.addSlider("chance")
    .setPosition(10, 90)
    .setRange(0, 1)
    ;

  cp5.addSlider("particleSize")
    .setPosition(10, 110)
    .setRange(1, 10)
    ;
}