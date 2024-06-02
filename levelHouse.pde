class LevelHouse extends Level {
  PImage livingroomImg, bathroomImg, sinkImg, balconyImg, kitchenImg, entranceImg, recyclePlaceImg, introImg;
  PImage watersaveImg, switchImg, tableToolsImg, trashImg, carKeyImg, motorKeyImg, recycleCarImg, wrenchImg, phoneImg, laundryImg,
    controllerImg, foodwareImg, heaterPlugedImg, heaterUnplugedImg, bagImg, cripserImg, guidebookImg, toiletriesImg, baggageImg;

  BooleanWrapper isLight = new BooleanWrapper(false);
  BooleanWrapper isFan = new BooleanWrapper(false);
  BooleanWrapper isWatersave = new BooleanWrapper(false);
  BooleanWrapper isBag = new BooleanWrapper(false);
  BooleanWrapper isFoodware = new BooleanWrapper(false);
  BooleanWrapper isSwitch = new BooleanWrapper(false);
  BooleanWrapper isLaundry = new BooleanWrapper(false);
  BooleanWrapper isAircon = new BooleanWrapper(false);
  BooleanWrapper isShower = new BooleanWrapper(false);
  BooleanWrapper isFridge = new BooleanWrapper(false);
  BooleanWrapper isRecycle = new BooleanWrapper(false);
  BooleanWrapper isWrench = new BooleanWrapper(false);
  BooleanWrapper isHeater = new BooleanWrapper(false);
  BooleanWrapper isPreserve = new BooleanWrapper(false);
  BooleanWrapper isToiletries = new BooleanWrapper(false);
  BooleanWrapper isTravelBag = new BooleanWrapper(false);
  BooleanWrapper isTravelFoodware = new BooleanWrapper(false);

  BooleanWrapper toolPicked = new BooleanWrapper(false);
  BooleanWrapper trashPicked = new BooleanWrapper(false);
  BooleanWrapper carKeyPicked = new BooleanWrapper(false);
  BooleanWrapper motorKeyPicked = new BooleanWrapper(false);
  BooleanWrapper laundryPicked = new BooleanWrapper(false);
  BooleanWrapper phonePicked = new BooleanWrapper(false);
  BooleanWrapper wrenchPicked = new BooleanWrapper(false);
  BooleanWrapper cripserPicked = new BooleanWrapper(false);

  BooleanWrapper travelUnlock = new BooleanWrapper(false);

  LevelHouse() {
    introImg=loadImage("img/background/intro.png");
    livingroomImg = loadImage("img/background/livingroom.png");
    bathroomImg=loadImage("img/background/bathroom.jpg");
    sinkImg = loadImage("img/background/sink.png");
    balconyImg=loadImage("img/background/balcony.jpg");
    kitchenImg=loadImage("img/background/kitchen.png");
    entranceImg=loadImage("img/background/entrance.png");
    recyclePlaceImg=loadImage("img/background/recyclePlace.png");

    watersaveImg=loadImage("img/watersave.png");
    switchImg=loadImage("img/switch.png");
    tableToolsImg=loadImage("img/tableTools.png");
    trashImg=loadImage("img/trash.png");
    carKeyImg=loadImage("img/carKey.png");
    motorKeyImg=loadImage("img/motorKey.png");
    recycleCarImg=loadImage("img/recycleCar.png");
    wrenchImg=loadImage("img/wrench.png");
    phoneImg=loadImage("img/phone.png");
    laundryImg=loadImage("img/laundry.png");
    controllerImg=loadImage("img/controller.png");
    foodwareImg=loadImage("img/foodware.png");
    heaterPlugedImg=loadImage("img/heaterPluged.png");
    heaterUnplugedImg=loadImage("img/heaterUnPluged.png");
    bagImg=loadImage("img/bag.png");
    cripserImg=loadImage("img/cripser.png");
    guidebookImg=loadImage("img/guidebook.png");
    toiletriesImg=loadImage("img/toiletries.png");
    baggageImg=loadImage("img/baggage.png");
  }

  void display() {
    switch(currentPlace) {
    case "intro":
      image(introImg, 0, navHeight, width, height);
      narColor=color(0, 139, 69);
      narration="按滑鼠右鍵開始遊戲";
      break;
    case "livingroom":
      image(livingroomImg, 0, navHeight, width, height);
      image(goLeftImg, 10, screenHeight/2, 100, 100);
      image(goRightImg, 1810, screenHeight/2, 100, 100);
      image(goUpImg, screenWidth/2-50, navHeight+10, 100, 100);
      image(goDownImg, screenWidth/2-50, screenHeight-180, 100, 100);
      image(switchImg, 1700, 570, 100, 50);

      if (isAircon.value) image(correctImg, 600, 310);
      if (isLight.value) image(correctImg, 800, 130);
      if (!toolPicked.value) image(tableToolsImg, 800, 785, 70, 70);
      if (!phonePicked.value) image(phoneImg, 1000, 730, 35, 70);
      if (isFan.value) image(correctImg, 500, 600);
      if (isSwitch.value) image(correctImg, 1700, 570);

      if (isHeater.value) {
        image(heaterUnplugedImg, 90, 680, 300, 300);
        image(correctImg, 150, 750);
      } else {
        image(heaterPlugedImg, 90, 680, 300, 300);
      }
      break;
    case "sink":
      image(sinkImg, 0, navHeight, width, height);
      image(goDownImg, screenWidth/2-50, screenHeight-180, 100, 100);

      if (isWatersave.value) {
        image(correctImg, 700, 150);
        image(watersaveImg, 780, 350, 150, 150);
      }
      if (travelUnlock.value&&!isToiletries.value) image(toiletriesImg, 200, 350);
      break;
    case "bathroom":
      image(bathroomImg, 0, navHeight, width, height);
      image(goRightImg, screenWidth-110, screenHeight/2, 100, 100);

      if (isShower.value) image(correctImg, 140, 220);
      break;
    case "balcony":
      image(balconyImg, 0, navHeight, width, height);
      image(goDownImg, screenWidth/2-50, screenHeight-180, 100, 100);

      if (!wrenchPicked.value) image(wrenchImg, 1470, 840, 120, 120);
      if (isLaundry.value) image(correctImg, 400, 300);
      if (!travelUnlock.value) image(guidebookImg, 70, 740, 180, 130);
      break;
    case "kitchen":
      image(kitchenImg, 0, navHeight, width, height);
      image(goLeftImg, 10, screenHeight/2, 100, 100);

      if (isFridge.value)image(correctImg, 1500, 160);
      if (!cripserPicked.value)image(cripserImg, 500, 620, 80, 50);
      if (!trashPicked.value)image(trashImg, 170, 780, 250, 250);
      if (isPreserve.value) image(correctImg, 320, 610);
      if (travelUnlock.value&&!isTravelFoodware.value) image(foodwareImg, 1010, 600, 90, 70);
      break;
    case "entrance":
      image(entranceImg, 0, navHeight, width, height);
      image(goUpImg, screenWidth/2-50, navHeight+10, 100, 100);
      image(goDownImg, screenWidth/2-50, screenHeight-180, 100, 100);

      if (!carKeyPicked.value) image(carKeyImg, 1035, 570, 40, 40);
      if (travelUnlock.value&&!isTravelBag.value) image(bagImg, 1300, 700);
      break;
    case "recyclePlace":
      image(recyclePlaceImg, 0, navHeight, width, height);
      image(recycleCarImg, 200, 650, 450, 450);
      image(goRightImg, 1810, screenHeight/2, 100, 100);

      if (isRecycle.value) image(correctImg, 300, 800);
      break;
    default:
      // 如果 currentPlace 不符合任何已知情境時的預設情況
      break;
    }
    handleKeyPress();
  }
  void handleKeyPress() {
    switch(currentPlace) {
    case "intro":
      if (mousePressed&&mouseButton==RIGHT) {
        currentPlace="livingroom";
      }
      break;
    case "livingroom":
      moveDetect("bathroom", 10, screenHeight/2, 110, screenHeight/2 + 100, "浴室");
      moveDetect("balcony", screenWidth/2 - 50, navHeight + 10, screenWidth/2 + 50, navHeight + 110, "陽台");
      moveDetect("kitchen", 1810, screenHeight/2, 1910, screenHeight/2 + 100, "廚房");
      moveDetect("entrance", screenWidth/2 - 50, screenHeight - 180, screenWidth/2 + 50, screenHeight - 80, "玄關");
      interactWithTool(600, 310, 850, 390, isAircon, isProgress, "beep.mp3",
        "冷氣溫度建議在26度到28度，且每1度可省電力6%，只要調高1度，一年下來可省下247元和減碳可減碳38kgCO2e", "涼爽的20度冷氣", "冷氣遙控器", controllerImg);
      interact(800, 130, 1050, 220, isLight, isProgress, "",
        "更換LED燈泡耗電量低於省電燈泡70%，每年節省8.2125kgCO2e，同時提供明亮的照明效果。", "快壞掉的省電燈泡", "");
      interact(500, 600, 640, 840, isFan, isProgress, "fan.mp3",
        "冷氣機配合電扇或循環扇一起使用會「省電」、幫助室內空氣循環而加速降溫，讓冷氣機壓縮機運轉時間減少來省電", "沒開的電風扇", "");
      interact(770, 800, 850, 850, toolPicked, !isProgress, "",
        "得到了環保餐具、購物袋、遙控器和省水裝置", "外出用餐具、購物袋和一些有的沒的", "環保餐具", "購物袋", "省水裝置", "冷氣遙控器");
      interact(1700, 570, 1800, 620, isSwitch, isProgress, "switch.mp3",
        "只要每人每天關燈一小時，便能為地球減少至少0.25公斤的碳排放，假如全台2300萬人共同在這天關燈一小時來計算，換算後等於降低575萬公斤的碳排放量，相當是38座大安森林公園一年所能吸收的二氧化碳量，是不是沒想過透過小小的舉動，聚沙成塔後的結果竟然超級驚人可觀的啊",
        "客廳的電燈開關", "");
      interact(1000, 730, 1035, 800, phonePicked, !isProgress, "",
        "得到了手機", "我的手機", "手機");
      interact(90, 700, 390, 980, isHeater, isProgress, "unplug.mp3",
        "待機電力占家庭用電的7.4%，拔除插頭可以節能減碳，讓插頭休息，減少待機消耗。", "放在角落的電暖爐", "");
      break;
    case "bathroom":
      moveDetect("livingroom", 1810, screenHeight/2, 1910, screenHeight/2 + 100, "客廳");
      moveDetect("sink", 1270, 570, 1570, 670, "洗手台");
      interact(140, 220, 340, 280, isShower, isProgress, "shower.mp3",
        "淋浴用水量較少，能源消耗也相對減少。每年可減少1kgCO2e，為家中環保與節水兩全其美。", "蓮蓬頭", "");
      break;
    case "sink":
      moveDetect("bathroom", screenWidth/2 - 50, screenHeight - 180, screenWidth/2 + 50, screenHeight - 80, "浴室");
      if (isWrench.value) {
        interactWithTool(680, 130, 820, 400, isWatersave, isProgress, "wrench.mp3",
          "裝上省水裝置後每減少1度用水，可減少0.21公斤的碳排放，亦相當於減少4個人每日生活污水排放量", "可以換上省水裝置了", "省水裝置", watersaveImg);
      } else {
        interactWithTool(680, 130, 820, 400, isWrench, !isProgress, "wrench.mp3",
          "可以換上省水裝置了", "乾淨的洗手台", "板手", wrenchImg);
      }
      if (travelUnlock.value) {
        interact(200, 400, 650, 600, isToiletries, isProgress, "",
          "假設兩個人出遊兩天一夜選擇住進了環保旅館,他們自備自己的牙刷、牙膏、梳子、刮鬍刀、拖鞋等等物品, 這樣小小的環保行為, 可以少去 1.15 kgCO2e的碳排放量", "洗漱用具", "");
      }
      break;
    case "balcony":
      moveDetect("livingroom", screenWidth/2 - 50, screenHeight - 180, screenWidth/2 + 50, screenHeight - 80, "客廳");
      interact(300, 650, 660, 940, motorKeyPicked, !isProgress, "key.mp3",
        "烘衣機", "烘衣機，裡面似乎有個發光的東西", "機車鑰匙");
      interact(700, 650, 1070, 940, laundryPicked, !isProgress, "",
        "洗衣機", "剛洗完衣服的洗衣機", "剛洗好的衣服");
      interactWithTool(300, 280, 900, 470, isLaundry, isProgress, "cloth.mp3",
        "自然風乾衣物減少烘衣機能源消耗，每年可減少3kgCO2e，同時延長衣物使用壽命。", "灑滿陽光的曬衣架", "剛洗好的衣服", laundryImg);
      interact(1470, 840, 1600, 960, wrenchPicked, !isProgress, "",
        "得到了板手", "板手", "板手");
      interact(70, 740, 250, 870, travelUnlock, !isProgress, "",
        "旅遊已解鎖，目前行李箱已有換洗衣物等必備物品，請從家裡找出新產生的三項旅遊相關的環保用品，然後走出家門", "進度達到10可解鎖旅遊", "旅遊指南:請從家裡找出新產生的三項旅遊相關的環保用品，然後走出家門", "行李");
      if (progress<10) {
        travelUnlock.value=false;
      }
      break;
    case "kitchen":
      moveDetect("livingroom", 10, screenHeight/2, 110, screenHeight/2 + 100, "客廳");
      interact(1500, 160, 1800, 1000, isFridge, isProgress, "throw.mp3",
        "選擇取物後再關冰箱門，每年可減少25kgCO2e。冰箱門緊閉，能源慢走，為環保生活減碳。", "冰箱", "");
      interact(170, 780, 420, 1030, trashPicked, !isProgress, "plastic.mp3",
        "得到了一袋回收物", "一袋回收物", "一袋回收");
      interact(500, 610, 550, 690, cripserPicked, !isProgress, "throw.mp3",
        "拿到了保鮮盒", "保鮮盒", "保鮮盒");
      if (travelUnlock.value) {
        interact(1010, 590, 1100, 670, isTravelFoodware, isProgress, "",
          "出遊假設每人每餐都使用免洗餐具(塑膠飲料杯、塑膠吸管、免洗筷、塑膠湯匙、紙盒包),一日三餐就產生碳排 0.288kgCO2e,若自備環保餐具每人一日即可減少 0.287kgCO2e,小小習慣也可以為環境盡心力,現在就開始自備環保餐具吧!", "環保餐具", "");
      }
      interactWithTool(320, 610, 440, 670, isPreserve, isProgress, "",
        "每公斤塑膠薄膜生產過程中的碳排放大約為1.9至3.5公斤，而平均每人每年塑膠袋使用量高達782個，使用1個塑膠袋會產生57公克碳排放量，使用可重複使用的容器減少一次性塑膠使用，保存食物同時也保護地球。", "剩菜", "保鮮盒", cripserImg);
      break;
    case "entrance":
      moveDetect("livingroom", screenWidth/2 - 50, screenHeight - 180, screenWidth/2 + 50, screenHeight - 80, "客廳");
       if (travelUnlock.value==false||levelTravel.completed==true) {
        moveDetect("outside", screenWidth/2 - 50, navHeight + 10, screenWidth/2 + 50, navHeight + 110, "外出");
      } else {
        moveDetect("scenery", screenWidth/2 - 50, navHeight + 10, screenWidth/2 + 50, navHeight + 110, "外出", "travelBg.mp3");
        narration="選擇大眾運輸可以顯著減少個人碳足跡。每小時使用公車或捷運可減少133gCO2e，節省能源，改善城市空氣品質。";
      }
      interact(1035, 570, 1075, 610, carKeyPicked, !isProgress, "key.mp3", "拿到了汽車鑰匙", "汽車鑰匙", "汽車鑰匙");
      if (travelUnlock.value) {
        interact(1300, 700, 1500, 1000, isTravelBag, isProgress, "", "假設每人每天旅遊會使用到 5 個塑膠袋,一天碳排量為 0.01125 kgCO2e,若使用環保袋取代則可以減少 0.0109 kgCO2e,隨身攜帶環保袋這麼簡單又環保的事請盡量在生活日常實踐喔!", "環保袋", "");
      }
      break;
    case "recyclePlace":
      moveDetect("outside", 1810, screenHeight/2, 1910, screenHeight/2 + 100, "返回");
      interactWithTool(200, 650, 650, 1100, isRecycle, isProgress, "throw.mp3", "資源回收能減少垃圾焚化碳排放，每日減少0.18kgCO2e。垃圾分類，資源再利用，為環保減碳，從小做起。", "資源回收車", "一袋回收", trashImg);
      break;
    default:
      // 如果 currentPlace 不符合任何已知情境時的預設情況
      break;
    }
  }
}
