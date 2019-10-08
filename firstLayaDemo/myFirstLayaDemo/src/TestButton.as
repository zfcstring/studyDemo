/*
 * @Author: Zhangfc 
 * @Date: 2019-09-06 09:25:20 
 * @Last Modified time: 2019-09-06 09:25:20 
 * @Title or Desc: 
 */
package {
  import laya.ui.Button;
  import laya.utils.Handler;
  import laya.display.Text;

  public class TestButton {
    var clickCount:int = 0;
    var txt:Text;
    public function TestButton() {
      Laya.init(800, 640);
      Laya.stage.bgColor = "#efefef";
      Laya.loader.load("testImg/test004.png", Handler.create(this, loadCompleted));
    }
    private function loadCompleted():void {
      trace("按钮加载完成!");
      var btn:Button = new Button("testImg/test004.png", "label");
      btn.x = 100;
      btn.y = 100;
      btn.clickHandler = new Handler(this, btnOnclick, [btn]);
      Laya.stage.addChild(btn);
    }
    private function btnOnclick(btn:Button):void {
      clickCount++;
      showCount();
    }
    private function showCount():void {
      Laya.stage.removeChild(txt);
      txt = new Text();
      txt.text = clickCount;
      txt.x = 100;
      txt.y = 200;
      Laya.stage.addChild(txt);
    }
  }
}