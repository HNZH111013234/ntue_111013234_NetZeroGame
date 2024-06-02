String currentPlace="intro", currentMusic="bg.mp3", lastPlace="";
LevelHouse levelHouse;
LevelShopping levelShopping;
LevelEatting levelEatting;
LevelTransporting levelTransporting;
LevelTravel levelTravel;
VegGame vegGame;
MeatGame meatGame;
ShelfGame shelfGame;

class Level {
  boolean isProgress=true;
  PImage correctImg, incorrectImg, goUpImg, goDownImg, goLeftImg, goRightImg, altImg, mouseImg1, mouseImg2;

  Level() { 
    correctImg=loadImage("img/correct.png");
    incorrectImg=loadImage("img/incorrect.png");
    goUpImg=loadImage("img/ui/up.png");
    goDownImg=loadImage("img/ui/down.png");
    goLeftImg=loadImage("img/ui/left.png");
    goRightImg=loadImage("img/ui/right.png");
    altImg=loadImage("img/ui/alt.png");
    mouseImg1=loadImage("img/mouse1.png");
    mouseImg2=loadImage("img/mouse2.png");
  }
  void generateLevel() {
    levelHouse=new LevelHouse();
    levelShopping=new LevelShopping();
    levelEatting=new LevelEatting();
    levelTransporting= new LevelTransporting();
    levelTravel=new LevelTravel();
    vegGame=new VegGame();
    meatGame=new MeatGame();
    shelfGame=new ShelfGame();
  }
  void update() {
    levelHouse.display();
    levelShopping.display();
    levelEatting.display();
    levelTransporting.display();
    levelTravel.display();
    vegGame.display();
    meatGame.display();
    shelfGame.display();

    if (progress<10) {
      image(mouseImg1, mouseX-20, mouseY-20, 60, 60);
    } else if (progress<26) {
      image(mouseImg2, mouseX-30, mouseY-30, 80, 80);
    } else {
      game.gameOver=true;
      progress=0;
    }
  }

  void handleKeyPress() {
    // 處理關卡的按鍵事件
  }

  void interact (int x1, int y1, int x2, int y2, BooleanWrapper isDone, boolean isProgress, String sound, String nar1, String nar2, String...tools) {
    if (mouseX >x1  && mouseX <x2 && mouseY >y1 && mouseY <y2) {
      if (mousePressed && !isDone.value) {
        mousePressed=false;
        if (sound!="") {
          soundEffect=minim.loadFile("/music/"+sound);
          try {
            soundEffect.play();
          }
          catch (NullPointerException e) {
          }
        }
        if (isProgress) {
          soundEffect=minim.loadFile("/music/correct.mp3");
          try {
            soundEffect.play();
          }
          catch (NullPointerException e) {
          }
          progress+=1;
        }
        isDone.value=true;
        if (tools[0]!="") {
          for (String tool : tools) {
            toolList.add(tool);
          }
        }
      }
      if (isDone.value) {
        narColor=color(0, 139, 69);
        narration=nar1;
      } else {
        narColor=color(0, 139, 69);
        narration=nar2;
      }
    }
  }
  void interactWithTool (int x1, int y1, int x2, int y2, BooleanWrapper isDone, boolean isProgress, String sound, String nar1, String nar2, String tool, PImage img) {
    if (mouseX >x1  && mouseX <x2 && mouseY >y1 && mouseY <y2) {
      if (mousePressed && !isDone.value&&choosedItem==tool) {
        mousePressed=false;
        soundEffect=minim.loadFile("/music/"+sound);
        try {
          soundEffect.play();
        }
        catch (NullPointerException e) {
        }
        toolUsed=true;
        toolList.remove(tool);
        if (isProgress) progress+=1;
        isDone.value=true;
      }
      if (isDone.value) {
        narColor=color(0, 139, 69);
        narration=nar1;
      } else {
        narColor=color(0, 139, 69);
        narration=nar2 ;
      }
    }
  }
  void moveDetect(String place, int x1, int y1, int x2, int y2, String nar) {
    if (mouseX >x1  && mouseX <x2 && mouseY >y1 && mouseY <y2) {
      if (mousePressed) {
        mousePressed=false;
        currentPlace=place;
      } else {
        narColor=color(0, 139, 69);
        narration=nar;
      }
    }
  }
  void moveDetect(String place, int x1, int y1, int x2, int y2, String nar, String music) {
    if (mouseX >x1  && mouseX <x2 && mouseY >y1 && mouseY <y2) {
      if (mousePressed) {
        mousePressed=false;
        currentPlace=place;
        currentMusic=music;
        bgMusic.close();
        bgMusic = minim.loadFile("/music/"+music);
        bgMusic.loop();
      } else {
        narColor=color(0, 139, 69);
        narration=nar;
      }
    }
  }
}


class BooleanWrapper {
  boolean value;

  BooleanWrapper(boolean value) {
    this.value = value;
  }
}
