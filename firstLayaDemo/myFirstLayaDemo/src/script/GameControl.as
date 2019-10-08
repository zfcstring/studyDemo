package script {
	import laya.components.Prefab;
	import laya.components.Script;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Browser;
	import laya.utils.Pool;
	
	/**
	 * 游戏控制脚本。定义了几个dropBox，bullet，createBoxInterval等变量，能够在IDE显示及设置该变量
	 * 更多类型定义，请参考官方文档
	 */
	public class GameControl extends Script {
		/** @prop {name:dropBox,tips:"掉落容器预制体对象",type:Prefab}*/
		public var dropBox:Prefab;
		/** @prop {name:buffBox,tips:"掉落buff容器预制体对象",type:Prefab}*/
		public var buffBox:Prefab;
		/** @prop {name:bullet,tips:"子弹预制体对象",type:Prefab}*/
		public var bullet:Prefab;
		/** @prop {name:createBoxInterval,tips:"间隔多少毫秒创建一个下跌的容器",type:int,default=1000}*/
		public var createBoxInterval:Number = 1000;
		/**开始时间*/
		private var _time:Number = 0;
		/**是否已经开始游戏 */
		private var _started:Boolean = false;
		/**子弹和盒子所在的容器对象 */
		private var _gameBox:Sprite;
		/* 连发状态 */
		private var _bulletting:Boolean = false;
		/* 连发间隔 */
		private var _bulletTimer:Number = 100;
		/* 是否开启连发 */
		private var _bulletIsAble = true;
		/* buff概率 */
		private var buffChance:Number;
		
		override public function onEnable():void {
			this._time = Browser.now();
			this._gameBox = this.owner.getChildByName("gameBox") as Sprite;
			// 自动开始游戏
			// this.createBox();
			// GameUI.instance.tipLbll.visible = false;
			// startGame();
		}
		
		override public function onUpdate():void {
			//每间隔一段时间创建一个盒子
			var now:* = Browser.now();
			if (now - this._time > this.createBoxInterval) {
				this._time = now;
				this.createBox();
				// 随机创建一个buffBox
				// this.createBuff();
				buffChance = parseInt(Math.random() * 10) - 2;
				// trace("buff概率:", buffChance);
				if (buffChance <= 0) {
					this.createBuff();
				}
			}
		}
		
		public function createBuff():void {
			// 使用对象池创建buff
			var buff:Sprite = Pool.getItemByCreateFun("buffBox", this.buffBox.create, this.buffBox);
			buff.pos(Math.random() * (Laya.stage.width - 100), -100);
			this._gameBox.addChild(buff);
		}
		public function createBox():void {
			//使用对象池创建盒子
			var box:Sprite = Pool.getItemByCreateFun("dropBox", this.dropBox.create, this.dropBox);
			box.pos(Math.random() * (Laya.stage.width - 100), -100);
			this._gameBox.addChild(box);
		}
		/* 获取连发是否开启 */
		public function get bulletIsAble(isAble:Boolean):void {
			return _bulletIsAble;
		}
		/* 开启和关闭连发 */
		public function set bulletIsAble(isAble:Boolean):void {
			_bulletIsAble = isAble;
		}
		private function creatBullet():void {
			//舞台被点击后，使用对象池创建子弹
			var flyer:Sprite = Pool.getItemByCreateFun("bullet", this.bullet.create, this.bullet);
			trace("子弹对象容器:", flyer);
			flyer.pos(Laya.stage.mouseX, Laya.stage.mouseY);
			this._gameBox.addChild(flyer);
		}

		override public function onStageClick(e:Event):void {
			//停止事件冒泡，提高性能，当然也可以不要
			e.stopPropagation();
			creatBullet();
		}
		
		// 游戏连发,按下鼠标不动则每隔 _bulletTimer 毫秒发射一个子弹
		override public function onStageMouseDown(e:Event):void {
			//停止事件冒泡，提高性能，当然也可以不要
			e.stopPropagation();
			if (_bulletIsAble) {
				Laya.timer.loop(_bulletTimer, this, creatBullet);
				// 设置处于连发状态
				_bulletting = true;
			}
		}
		override public function onStageMouseUp(e:Event):void {
			// 停止连发
			Laya.timer.clearAll(this);
			_bulletting = false;
		}
		override public function onMouseMove(e:Event):void {
			// 鼠标移出舞台,停止连发
			if (Laya.stage.mouseX < 0 || Laya.stage.mouseX > Laya.stage.width || Laya.stage.mouseY < 0 || Laya.stage.mouseY > Laya.stage.height - 280) {
				Laya.timer.clearAll(this);
				_bulletting = false;
			}
		}
		
		/**开始游戏，通过激活本脚本方式开始游戏*/
		public function startGame():void {
			if (!this._started) {
				this._started = true;
				this.enabled = true;
			}
		}
		
		/**结束游戏，通过非激活本脚本停止游戏 */
		public function stopGame():void {
			this._started = false;
			this.enabled = false;
			this.createBoxInterval = 1000;
			this._gameBox.removeChildren();
		}
	}
}