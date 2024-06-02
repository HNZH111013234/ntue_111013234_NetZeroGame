class HelpScreen {
  String[] hint = {
    "天花板的電燈，試著點擊看看會發生什麼。", "點擊房間中的風扇，觀察是否有變化。", "左下角有一個暖爐，試著點擊看看。",
    "桌上似乎有一些物品，看看能不能撿起來。", "沙發上有一部手機，試著把它撿起來。", "桌上有一個遙控器，可以用它來操作冷氣。",
    "找到電燈開關，試著開或關電燈。", "檢查洗手台附近，看有沒有需要的旅遊物品。", "看看廚房的流理台上有沒有需要的旅遊物品。",
    "檢查門口的地上，看有沒有需要的旅遊物品。", "浴室裡的蓮蓬頭，試著點擊看看會發生什麼。", "檢查一下洗手台有沒有什麼特別的地方。",
    "躺椅上有一本旅遊手冊，看看裡面有什麼資訊。", "椅子上掛著一個板手，試著撿起來。", "右側有一台洗衣機",
    "左側有一台烘衣機", "找一個適合晾乾衣服的地方，把洗好的衣服掛起來。", "廚房裡有一些需要資源回收的物品。",
    "看看水槽旁的保鮮盒。", "把鍋子裡的剩菜放進保鮮盒並放進冰箱。", "打開冰箱",
    "看看門口矮櫃上", "把回收垃圾袋丟進資源回收車。", "前方是夾菜區可以選菜。",
    "找到一個合適的座位坐下來。", "找找看有沒有餐具。", "需要省水裝置和板手來改良水龍頭"
  };
  HelpScreen() {
  }

  void display() {
    handleKeyPress();
  }

  void handleKeyPress() {
    if (mouseX >width * 14/16  && mouseX <width*15/16 && mouseY >0 && mouseY <navHeight) {
      if (mousePressed) {
        mousePressed=false;
        switch (currentPlace) {
        case "livingroom":
          if (levelHouse.travelUnlock.value==true&&levelTravel.completed==false) {
            narColor=color(139 ,76 ,57);
            narration = hint[int(random(0, 9))];
          } else {
            narColor=color(139 ,76 ,57);
            narration = hint[int(random(0, 6))];
          }
          break;
        case "bathroom":
          narColor=color(139 ,76 ,57);
          narration = hint[int(random(10, 12))];
          break;
        case "sink":
          narColor=color(139 ,76 ,57);
          narration = hint[int(random(26, 27))];
          break;
        case "balcony":
          narColor=color(139 ,76 ,57);
          narration = hint[int(random(12, 17))];
          break;
        case "kitchen":
          narColor=color(139 ,76 ,57);
          narration = hint[int(random(18, 21))];
          break;
        case "entrance":
          narColor=color(139 ,76 ,57);
          narration = hint[int(random(21, 22))];
          break;
        case "recyclePlace":
          narColor=color(139 ,76 ,57);
          narration = hint[int(random(22, 23))];
          break;
        case "cafeteria":
          narColor=color(139 ,76 ,57);
          narration = hint[int(random(23, 25))];
          break;
        case "table":
          narColor=color(139 ,76 ,57);
          narration = hint[int(random(25, 26))];
          break;
        case "meat game":
          narColor=color(139 ,76 ,57);
          currentPlace = "meat instruction";
          narration = "按滑鼠左鍵到下一頁，右鍵返回";
          break;
        case "veg game":
          narColor=color(139 ,76 ,57);
          currentPlace = "veg instruction";
          narration = "按滑鼠左鍵到下一頁，右鍵返回";
          break;
        case "shelf game":
          narColor=color(139 ,76 ,57);
          currentPlace = "shelf instruction";
          narration = "按滑鼠左鍵到下一頁，右鍵返回";
          break;
        }
      }
    }
  }
}
