String narration = "旁白";
int segmentLength = 40; // 每段的字數
int currentIndex = 0; // 目前顯示的段落索引
int displayDuration = 8000; // 每段顯示的持續時間（毫秒）
int startTime; // 段落開始顯示的時間
int progress=0; // 當前進度
int finish=26;
int navHeight = 80; // 導覽列高度
color narColor=color(0, 139, 69);

class NavigationBar extends Level {
  String axis;
  String segment;
  PImage helpImage;
  PImage settingImage;

  NavigationBar() {
    helpImage=loadImage("img/ui/help.png");
    settingImage=loadImage("img/ui/setting.png");
  }

  // 顯示導覽列
  void display() {
    textAlign(LEFT, CENTER);
    stroke(218, 165, 32);    
    // 計算目前顯示的段落
    int startIndex = currentIndex * segmentLength;
    int endIndex = min(startIndex + segmentLength, narration.length());
    try {
      segment = narration.substring(startIndex, endIndex);
    }
    catch (StringIndexOutOfBoundsException e) {
      segment = narration;
    }
    if (millis() - startTime >= displayDuration) {
      if (segmentLength!=0) {
        currentIndex = (currentIndex + 1) % ceil(float(narration.length()) / segmentLength);
      }
      startTime = millis(); // 更新開始時間
    }
    // 顯示進度條
    fill(255);
    rect(0, 0, width/8, navHeight);
    // 顯示進度百分比
    fill(0);
    text("進度" + progress + "/"+finish, 10, navHeight / 2);
    
    // 顯示文字提示區塊
    fill(255);
    rect(width / 8, 0, width * 6/8, navHeight);
    axis="X:"+mouseX+"/Y:"+mouseY;
    fill(narColor);
    text(segment, width / 8, navHeight / 2-5);
    //text(axis, width / 8, navHeight -15);

    // 顯示問號按鈕
    fill(255);
    rect(width * 14/16, 0, width*1/16, navHeight);
    image(helpImage, width * 14/16, 0, width*1/16, navHeight);

    // 顯示設定按鈕
    fill(255);
    rect(width * 15/16, 0, width*1/16, navHeight);
    image(settingImage, width * 15/16, 0, width*1/16, navHeight);

    handleKeyPress();
  }

  // 處理滑鼠點擊事件
  void handleKeyPress() {
  }
}
