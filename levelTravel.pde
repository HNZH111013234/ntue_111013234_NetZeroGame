class LevelTravel extends Level {
  PImage hotelImg, souvenirImg;
  PImage[] images = new PImage[10];
  int currentImage = 0;
  float scale = 1.0;
  int interval = 3000; // 3秒
  int lastSwitchTime = 0;
  boolean completed=false;

  BooleanWrapper hotelChoosed = new BooleanWrapper(false);
  BooleanWrapper souvenirChoosed = new BooleanWrapper(false);

  LevelTravel() {
    hotelImg = loadImage("img/background/travel/hotel.png");
    souvenirImg = loadImage("img/background/travel/souvenir.png");
    for (int i = 0; i < images.length; i++) {
      images[i] = loadImage("img/background/travel/"+(i + 1) + ".jpg");
    }
    lastSwitchTime = millis();
  }

  void display() {
    if (currentPlace=="scenery") {
      PImage img = images[currentImage];
      // 計算圖片顯示的寬度和高度
      float imgWidth = width * scale;
      float imgHeight = height * scale;
      float imgX = width / 2 - imgWidth / 2;
      float imgY = height / 2 - imgHeight / 2;
      interval=2000;
      image(img, imgX, imgY, imgWidth, imgHeight);

      if (millis() - lastSwitchTime > interval) {
        scale = 1.0; // 重置縮放比例
        currentImage = (currentImage + 1) % images.length;
        if (currentImage==9)  currentPlace="travelChoice";
        lastSwitchTime = millis();
      } else {
        scale += 0.01;
      }
    }
    if (currentPlace=="travelChoice") {
      if (!hotelChoosed.value) {
        image(hotelImg, 0, navHeight, width, height);
      } else if (!souvenirChoosed.value) {
        image(souvenirImg, 0, navHeight, width, height);
        image(hotelImg, width*1/3, navHeight+600, width*1/3, 400);
      } else {
        PImage img = images[currentImage];
        float imgWidth = width * scale;
        float imgHeight = height * scale;
        float imgX = width / 2 - imgWidth / 2;
        float imgY = height / 2 - imgHeight / 2;
        interval=1000;
        image(img, imgX, imgY, imgWidth, imgHeight);

        if (millis() - lastSwitchTime > interval) {
          scale = 1.0; // 重置縮放比例
          currentImage = (currentImage -1) % images.length;
          if (currentImage==0) {
            completed=true;
            currentPlace="livingroom";
            bgMusic.close();
            bgMusic = minim.loadFile("/music/bg.mp3");
            bgMusic.loop();
            toolList.remove("旅遊指南:請從家裡找出新產生的三項旅遊相關的環保用品，然後走出家門");
            toolList.remove("行李");
          }
          lastSwitchTime = millis();
        } else {
          scale += 0.01;
        }
      }
      handleKeyPress();
    }
  }
  void handleKeyPress() {
    if (currentPlace == "travelChoice") {
      if (!hotelChoosed.value) {
        interact(0, navHeight, 850, 800, hotelChoosed, isProgress, "",
          "在規劃旅行住宿安排時,可優先選擇環保旅店(寬鬆)或環保標章旅館(嚴格),其鼓勵業者多加投入環保相關措施，主動降低營運時所產生之環境衝擊", "選擇大眾運輸可以顯著減少個人碳足跡。每小時使用公車或捷運可減少133gCO2e，節省能源，改善城市空氣品質。", "");
        interact(850, navHeight, width, 800, hotelChoosed, isProgress, "incorrect.mp3 ",
          "在規劃旅行住宿安排時,可優先選擇環保旅店(寬鬆)或環保標章旅館(嚴格),其鼓勵業者多加投入環保相關措施，主動降低營運時所產生之環境衝擊", "選擇大眾運輸可以顯著減少個人碳足跡。每小時使用公車或捷運可減少133gCO2e，節省能源，改善城市空氣品質。", "");
      } else {
        interact(0, navHeight, 960, 800, hotelChoosed, !isProgress, "",
          "在規劃旅行住宿安排時,可優先選擇環保旅店(寬鬆)或環保標章旅館(嚴格),其鼓勵業者多加投入環保相關措施，主動降低營運時所產生之環境衝擊", "無", "");
        interact(0, navHeight, 960, 800, souvenirChoosed, isProgress, "",
          "選擇無包裝或簡約包裝商品，每年可減少20kgCO2e。減少包裝，輕量化生活，為地球減少不必要的塑膠垃圾。", "在規劃旅行住宿安排時,可優先選擇環保旅店(寬鬆)或環保標章旅館(嚴格),其鼓勵業者多加投入環保相關措施，主動降低營運時所產生之環境衝擊", "");
        interact(960, navHeight, width, 800, souvenirChoosed, isProgress, "",
          "選擇無包裝或簡約包裝商品，每年可減少20kgCO2e。減少包裝，輕量化生活，為地球減少不必要的塑膠垃圾。", "在規劃旅行住宿安排時,可優先選擇環保旅店(寬鬆)或環保標章旅館(嚴格),其鼓勵業者多加投入環保相關措施，主動降低營運時所產生之環境衝擊", "");
      }
    }
  }
}
