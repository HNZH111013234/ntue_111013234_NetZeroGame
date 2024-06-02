import ddf.minim.*;
import java.util.ArrayList;
import java.awt.Desktop;
import java.net.URI;

Minim minim;
AudioPlayer bgMusic;
AudioPlayer soundEffect;
Game game;
int screenWidth=1920;
int screenHeight=1050;
int bgVolume = 20;
int seVolume = 0;
boolean soundEffectState=false;
float time=0;

void setup() {  
  size(1920, 1050, P3D);
  textFont(createFont("標楷體", 36));
  strokeWeight(3);
  game = new Game();
  minim = new Minim(this);
  bgMusic = minim.loadFile("/music/bg.mp3");
  startTime = millis(); // 字幕跑馬燈
  try {
    bgMusic.loop();
    bgMusic.setVolume(bgVolume-40);
    //soundEffect.setGain(seVolume-40);
  }
  catch (NullPointerException e) {
    println("無音訊裝置");
  }
}

void draw() {
  frameRate=30;
  background(255);
  game.draw();
  game.keyPressed();
}

void openLink(String url) {
  if (Desktop.isDesktopSupported()) {
    try {
      Desktop.getDesktop().browse(new URI(url));
    }
    catch (Exception e) {
      println("Error opening link: " + e.getMessage());
    }
  } else {
    println("Desktop is not supported, cannot open link.");
  }
}
