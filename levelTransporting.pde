class LevelTransporting extends Level {
  PImage outsideImg, recyclePlaceImg, cafeteriaImg, cafeteriaTransportationImg, groceryStoreTransportationImg;
  PImage carKeyImg, motorKeyImg, carImg, motorImg, busImg, MRTImg, bicycleImg;

  BooleanWrapper isCar = new BooleanWrapper(false);
  BooleanWrapper isBus = new BooleanWrapper(false);
  BooleanWrapper isMRT = new BooleanWrapper(false);
  BooleanWrapper isBicycle = new BooleanWrapper(false);
  BooleanWrapper isMotor = new BooleanWrapper(false);
  BooleanWrapper cafeteriaTransported = new BooleanWrapper(false);
  BooleanWrapper groceryStoreTransported = new BooleanWrapper(false);

  LevelTransporting() {
    outsideImg=loadImage("img/background/outside.png");
    recyclePlaceImg=loadImage("img/background/recyclePlace.png");
    cafeteriaImg = loadImage("img/background/cafeteria.png");
    groceryStoreTransportationImg=loadImage("img/background/groceryStoreTransportation.png");
    cafeteriaTransportationImg=loadImage("img/background/cafeteriaTransportation.png");

    carKeyImg=loadImage("img/carKey.png");
    motorKeyImg=loadImage("img/motorKey.png");
  }

  void display() {
    if (currentPlace=="outside") {
      image(outsideImg, 0, navHeight, width, height);
      image(goLeftImg, 10, screenHeight/2, 100, 100);
      image(goRightImg, 1810, screenHeight/2, 100, 100);
      image(goUpImg, screenWidth/2-50, navHeight+10, 100, 100);
      image(goDownImg, screenWidth/2-50, screenHeight-180, 100, 100);

      if (cafeteriaTransported.value) image(altImg, 1810, screenHeight/2+100, 100, 100);
      if (groceryStoreTransported.value) image(altImg, screenWidth/2+50, navHeight+10, 100, 100);
      
    } else if (currentPlace=="grocery store transportation") {
      image(groceryStoreTransportationImg, 0, navHeight, width, height-100);
      image(goDownImg, screenWidth/2-50, screenHeight-180, 100, 100);

      if (isBus.value) image(correctImg, 240, 720, 200, 200);
      if (isMRT.value) image(correctImg, 1000, 450, 300, 300);
      
    } else if (currentPlace=="cafeteria transportation") {
      image(cafeteriaTransportationImg, 0, navHeight, width, height-100);
      image(goLeftImg, 10, screenHeight/2, 100, 100);

      if (isBicycle.value) image(correctImg, 300, 650);
    }

    handleKeyPress();
  }
  void handleKeyPress() {
    if (currentPlace == "outside") {
      moveDetect("entrance", screenWidth/2 - 50, screenHeight - 180, screenWidth/2 + 50, screenHeight - 80, "玄關");
      moveDetect("recyclePlace", 10, screenHeight/2, 110, screenHeight/2 + 100, "街角回收車應該快到了");

      if (groceryStoreTransported.value) {
        moveDetect("grocery store entrance", screenWidth/2 - 50, navHeight + 10, screenWidth/2 + 50, navHeight + 110, "超市");
        moveDetect("grocery store transportation", screenWidth/2 +50, navHeight + 10, screenWidth/2 + 150, navHeight + 110, "選擇交通方式");
      } else {
        moveDetect("grocery store transportation", screenWidth/2 - 50, navHeight + 10, screenWidth/2 + 50, navHeight + 110, "前往超市");
      }
      if (cafeteriaTransported.value) {
        moveDetect("cafeteria", 1810, screenHeight/2, 1910, screenHeight/2 + 100, "附近一家常去的便當店");
        moveDetect("cafeteria transportation", 1810, screenHeight/2+100, 1910, screenHeight/2 + 200, "選擇交通方式");
      } else {
        moveDetect("cafeteria transportation", 1810, screenHeight/2, 1910, screenHeight/2 + 100, "前往附近一家常去的便當店");
      }
    } else if (currentPlace == "grocery store transportation") {
      moveDetect("outside", screenWidth/2 - 50, screenHeight - 180, screenWidth/2 + 50, screenHeight - 80, "返回");
      interactWithTool(30, 550, 400, 650, isCar, !isProgress, "car.mp3", "自行駕駛汽機車實屬較不環保，但是在非都會區中，大眾運輸系統相較而言較不發達，自行駕駛仍是唯一方案。多人共乘或是選擇碳排放量較低的品牌車種，也是一種響應環保的方法。", "汽車", "汽車鑰匙", carImg);
      interact(240, 720, 1030, 870, isBus, isProgress, "car.mp3", "以每人1公里來計算碳排放量：公車0.04 kgCO2較汽車(1800c.c) 0.11 kgCO2產生的碳排量低，", "公車", "");
      interact(510, 450, 1750, 650, isMRT, isProgress, "MRT.mp3", "以每人1公里來計算碳排放量：捷運0.04 kgCO2較汽車(1800c.c) 0.11 kgCO2產生的碳排量低，", "捷運", "");
      if ((isCar.value||isBus.value||isMRT.value)&&!groceryStoreTransported.value) {
        currentPlace="grocery store entrance";
        groceryStoreTransported.value=true;
      }
    } else if (currentPlace == "cafeteria transportation") {
      moveDetect("outside", 10, screenHeight/2, 110, screenHeight/2 + 100, "返回");
      interactWithTool(1000, 200, 1700, 800, isMotor, !isProgress, "motor.mp3", "自行駕駛汽機車實屬較不環保，但是在非都會區中，大眾運輸系統相較而言較不發達，自行駕駛仍是唯一方案。多人共乘或是選擇碳排放量較低的品牌車種，也是一種響應環保的方法。", "機車", "機車鑰匙", motorImg);
      interact(300, 650, 900, 900, isBicycle, isProgress, "bicycle.mp3", "近距離移動步行或腳踏車是首選，零碳排兼具健康", "腳踏車", "");
      if ((isBicycle.value||isMotor.value)&&!cafeteriaTransported.value) {
        currentPlace="cafeteria";
        cafeteriaTransported.value=true;
      }
    }
  }
}
