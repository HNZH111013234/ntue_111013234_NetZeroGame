class PauseScreen {

  PauseScreen() {
  }
  void slider(float x, float y, float len, float volume) {
    float sliderWidth = 15; // 滑桿的寬度
    float sliderHeight = 30; // 滑桿的高度
    fill(255);
    rect(0, 80, width, height);
    line(x, y, x + len, y);
    rect(map(volume, 0, 100, width*3/8, width*5/8), y-15, sliderWidth, sliderHeight);
  }

  void display() {
    if (currentPlace == "setting") {
      narColor=color(0, 139, 69);
      narration="按下滑鼠右鍵返回遊戲";
      slider(width*3/8, height / 4, width*2/8, bgVolume);
      //slider(width*3/8, height / 3, width*2/8, seVolume);
      fill(0);
      text("音量 " + bgVolume, width*3/8-150, height / 4);
      //text("音效 " + seVolume, width*3/8-150, height / 3);
    }
    handleKeyPress();
  }


  void handleKeyPress() {
    // 處理暫停畫面的按鍵事件
    if (mouseX >width * 15/16  && mouseX <width && mouseY >0 && mouseY <navHeight) {
      if (mousePressed) {
        mousePressed=false;
        lastPlace=currentPlace;
        currentPlace = "setting";
      }
    }
    if (currentPlace=="setting") {
      if (mousePressed&&mouseButton==RIGHT) {
        mousePressed=false;
        currentPlace =lastPlace;
      }
      if (mousePressed) {
        mousePressed=false;
        if (mouseX>width*3/8&&mouseX<width*5/8&&abs(mouseY-height/4)<20) {
          bgVolume = int(map(mouseX, width *3/8, width*5/8, 0, 100)); // 更新滑桿值為滑鼠的X座標
          bgMusic.close();
          bgMusic = minim.loadFile("/music/"+currentMusic);
          bgMusic.setGain(bgVolume-40);                    
          bgMusic.play();          
        }
        /*
        if (mouseX>width*3/8&&mouseX<width*5/8&&(abs(mouseY-height/3)<20)) {
          seVolume =int(map(mouseX, width *3/8, width*5/8, 0, 100)); // 更新滑桿值為滑鼠的X座標
          soundEffect.setVolume(seVolume);
        }*/
      }
    }
  }
}
