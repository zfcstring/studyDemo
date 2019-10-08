/*
 * @Author: Zhangfc 
 * @Date: 2019-09-03 16:50:19 
 * @Last Modified time: 2019-09-03 16:50:19 
 * @Title or Desc: 文本动画
 */
package {
  import laya.d3.math.Rand;
  import laya.display.Text;
  import laya.utils.Tween;
  import laya.utils.Ease;
  import laya.webgl.WebGL;
  import laya.utils.Handler;

  public class TweenDemo {
    public function TweenDemo()
    {
      // 初始化
      Laya.init(1334, 750, WebGL);
      Laya.stage.bgColor = "#1b2436";
      // 创建缓动文本
      createTween();
    }
    // 创建缓动文本
    private function createTween():void
    {
      // 字符宽度
      var w:int = 800;
      //文本创建时的起始x位置(>>在此使用右移运算符，相当于/2 用>>效率更高)
      var offsetX:int = Laya.stage.width - w >> 1;
      var demoStr:String = "LayaDemo";
      var testTxt:Text;
      for (var i:int = 0, len:int = demoStr.length; i < len; i++) {
        testTxt = createTestStr(demoStr.charAt(i));
        testTxt.x = w / len * i + offsetX;
        testTxt.y = 100;
        //对象letterText属性y从缓动目标的100向初始的y属性300运动，每次执行缓动效果需要3000毫秒，缓类型采用elasticOut函数方式，延迟间隔i*1000毫秒执行。
        Tween.to(testTxt, { y: 300, update: new Handler(this, updateColor, [testTxt]) }, 1000, Ease.bounceIn, Handler.create(this, changeColor, [testTxt]), i * 500);
      }
    }
    // 动画进行时的回调
    private function updateColor(txt:Text):void
    {
      var colors:Array = ["white", "bule", "green", "yellow", "black", "red", "purple"];
      var num:int = parseInt(Math.random() * colors.length);
      txt.color = colors[num];
    }
    // 动画完成后的回调函数
    private function changeColor(txt:Text):void
    {
      txt.color = "red";
    }
    // 创建单字符,并加载到舞台
    private function createTestStr(char: String):Text {
      var letter:Text = new Text();
      letter.text = char;
      letter.color = "#fff";
      letter.font = "Impact";
      letter.fontSize = 120;
      Laya.stage.addChild(letter);
      return letter;
    }
  }
}