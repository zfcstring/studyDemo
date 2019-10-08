/*
 * @Author: Zhangfc 
 * @Date: 2019-09-06 14:17:48 
 * @Last Modified time: 2019-09-06 14:17:48 
 * @Title or Desc: 
 */
package {
  import laya.display.Sprite;
	import laya.display.Stage;
	import laya.filters.GlowFilter;
	import laya.resource.Texture;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import laya.webgl.WebGL;

  public class TestGlowFilter{
    private const imgObj = "testImg/test002.png";
    private var ape:Sprite;

    public function TestGlowFilter() {
      // 不支持WebGL时自动切换至Canvas
			Laya.init(Browser.clientWidth, Browser.clientHeight, WebGL);
      Laya.stage.alignV = Stage.ALIGN_MIDDLE;
			Laya.stage.alignH = Stage.ALIGN_CENTER;

			Laya.stage.scaleMode = "showall";
			Laya.stage.bgColor = "#232628";

			Laya.loader.load(imgObj, Handler.create(this, setup));
    }
    private function setup():void {
      createApe();
      applayFilter();
    }
    private function createApe():void {
      ape = new Sprite();
			ape.loadImage(imgObj);

			var texture:Texture = Laya.loader.getRes(imgObj);
			ape.x = (Laya.stage.width - texture.width) / 2;
			ape.y = (Laya.stage.height - texture.height) / 2;

			Laya.stage.addChild(ape);
    }
    private function applayFilter():void {
      //创建一个发光滤镜
			var glowFilter:GlowFilter = new GlowFilter("#ffff00", 50, 0, 0);
			//设置滤镜集合为发光滤镜
			ape.filters = [glowFilter];
    }
  }
}