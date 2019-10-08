/*
 * @Author: Zhangfc 
 * @Date: 2019-09-06 17:46:26 
 * @Last Modified time: 2019-09-06 17:46:26 
 * @Title or Desc: 自制下雨特效
 */
package {
	import laya.display.Stage;
  import laya.display.Sprite;
  import laya.ui.Button;
  import laya.utils.Handler;
  import laya.utils.Pool;
	import laya.utils.Browser;
  import laya.webgl.WebGL;
  import laya.utils.Stat;

  public class TestRain{
    var x:int = Math.random() * 1000 + 100;
    var y:int = Math.random() * 100;
    var width:int = 2;
    var height:int = 20;
    public function TestRain(){
      // 不支持WebGL时自动切换至Canvas
			Laya.init(Browser.clientWidth, Browser.clientHeight, WebGL);
      Stat.show(0,0); 
      Laya.stage.alignV = Stage.ALIGN_MIDDLE;
			Laya.stage.alignH = Stage.ALIGN_CENTER;
			Laya.stage.scaleMode = "showall";
			Laya.stage.bgColor = "#232628";
      Laya.loader.load("testImg/test005.png", Handler.create(this, loadCompleted));
    }
    private function loadCompleted():void {
      var btn:Button = new Button("testImg/test005.png", "点击开始");
      btn.pos(Browser.clientWidth - 120, 20);
      btn.width = 100;
      btn.height = 50;
      btn.clickHandler = new Handler(this, btnOnclick, [btn]);
      Laya.stage.addChild(btn);
    }
    private function btnOnclick(btn:Button):void {
      //帧循环
      // Laya.timer.frameLoop(1, this, drawRain);
      // Laya.stage.removeChild(btn);
      drawRain();
    }
    private function drawRain():void {
      var rain:Sprite = Pool.getItemByClass("rain", Sprite); // Pool.getItemByClass("img", Image)
      Laya.stage.addChild(rain);
      // 创建雨滴
      for (var i:int = 0; i < 100; i++) {
        rain.graphics.drawRect(x, y, width, height, "#fff");
      }
      Laya.timer.frameLoop(1, this, raining);
    }
    private function raining():void {
      for (var j:int = 0; j < Laya.stage.numChildren; j++) {
        // 获取舞台中的对象
        var rainObj:Sprite = Laya.stage.getChildAt(j) as Sprite;
        rainObj.y++;
        if (rainObj.y >= Browser.clientHeight) {
          rainObj.y = y;
        }
      }
    }
  }
}
