package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 並び替えBOX
	 * @author kaede
	 */
	public class RearrangeBox extends Sprite {
		
		private var vbox : VerticalBox;
		private var swapFrom:Sprite;//ドラッグ元
		private var dragTarget:Sprite;//実際ドラッグされているクローン
		
		public function RearrangeBox(){
			vbox = super.addChild(new VerticalBox) as VerticalBox;
			vbox.spacing = 0;
			vbox.addEventListener(MouseEvent.MOUSE_DOWN, mosueDownHandler);
		}

		private function mosueDownHandler(event : MouseEvent) : void {
			swapFrom = event.target as Sprite;
			//ドラッグもとのクローンを作り、そのオブジェクトをドラッグさせる
			dragTarget = super.addChild(createDragTarget(swapFrom)) as Sprite;
			//ドラッグの開始
			dragTarget.startDrag(false,new Rectangle(0,0,0,vbox.height-20));
			stage.addEventListener(MouseEvent.MOUSE_UP, mosueUpHandler)
		}
		
		private function mosueUpHandler(event : MouseEvent) : void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, mosueUpHandler);
			//ドロップに一番近いオブジェクトを参照
			var swapTarget:DisplayObject = getSwapTarget();
			stopDrag();
			//並び替え
			vbox.swapChildren(swapFrom, swapTarget);
			//クローンを削除
			super.removeChild(dragTarget);
			//並び替えイベントの発行
			dispatchEvent(new RearrangeEvent(RearrangeEvent.CHANGE, swapFrom,swapTarget));
			dragTarget = null;
			swapFrom = null;
		}

		/**
		 * ドラッグされているオブジェクトから一番近いオブジェクトを得る
		 */
		private function getSwapTarget() : DisplayObject {
			var arr:Array = [];
			for(var i:int=0;i<vbox.numChildren;i++){
				var swapTarget:DisplayObject = vbox.getChildAt(i);
				if(swapFrom && swapTarget != swapFrom){
					var obj:Object = {
						target:swapTarget,
						d:Point.distance(
										new Point((dragTarget.x)+(dragTarget.width/2),(dragTarget.y)+(dragTarget.height/2)),
										new Point((swapTarget.x)+(swapTarget.width/2),(swapTarget.y)+(swapTarget.height/2))
						)
					}
					if(obj.d <= swapTarget.height/2){
						arr.push(obj);
					}
				}
			}
			if(arr.length){
				return arr.sortOn("d",Array.NUMERIC)[0].target
			}else{
				return null
			}
		}
		
		/**
		 * 並び替えリストから実際にドラッグされるオブジェクトを生成する
		 */
		private function createDragTarget(target:DisplayObject):Sprite{
			var sp:Sprite = new Sprite();
			var bd:BitmapData = new BitmapData(target.width, target.height);
			bd.draw(target);
			sp.addChild(new Bitmap(bd));
			sp.x = target.x;
			sp.y = target.y;
			sp.alpha = .8;
			return sp;
		}
		
		/**
		 * addChildはVBOXに受け渡される。
		 */
		override public function addChild(child : DisplayObject) : DisplayObject {
			return vbox.addChild(child);
		}
		
		
		override public function removeChild(child : DisplayObject) : DisplayObject {
			return vbox.removeChild(child);
		}
		
		public function removeChildren() : void{
			vbox.removeChildren();
		}
		
		
	}
}