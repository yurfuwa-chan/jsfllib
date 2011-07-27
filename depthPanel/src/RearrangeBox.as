package {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 入れ替えBOX
	 * @author kaede
	 */
	public class RearrangeBox extends Sprite {
		
		private var vbox : VerticalBox;
		private var dragData:DragData;
		
		public function RearrangeBox(){
			dragData = new DragData;
			vbox = super.addChild(new VerticalBox) as VerticalBox;
			vbox.spacing = 0;
			vbox.addEventListener(MouseEvent.MOUSE_DOWN, mosueDownHandler);
		}

		private function mosueUpHandler(event : MouseEvent) : void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, mosueUpHandler);
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stopDrag();
			vbox.swapChildren(dragData.dragTarget, dragData.swapTarget);
			dispatchEvent(new RearrangeEvent(RearrangeEvent.CHANGE, dragData.dragTarget,dragData.swapTarget))
			super.removeChild(dragData.dragClone)
			dragData.init(); 
		}

		private function mosueDownHandler(event : MouseEvent) : void {
			dragData.dragTarget = event.target as Sprite;
			super.addChild(dragData.dragClone);
			dragData.dragClone.startDrag(false,new Rectangle(0,0,0,vbox.height-20));
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mosueUpHandler)
		}

		private function enterFrameHandler(event : Event) : void {
			var arr:Array = [];
			for(var i:int=0;i<vbox.numChildren;i++){
				var target:DisplayObject = vbox.getChildAt(i);
				if(dragData.dragTarget && target != dragData.dragTarget){
					var obj:Object = {
						target:target,
						d:Point.distance(
										new Point((dragData.dragClone.x)+(dragData.dragClone.width/2),(dragData.dragClone.y)+(dragData.dragClone.height/2)),
										new Point((target.x)+(target.width/2),(target.y)+(target.height/2))
						)
					}
					if(obj.d <= target.height/2){
						arr.push(obj);
						dragData.swapTarget = arr.sortOn("d",Array.NUMERIC)[0].target
					}
				}
			}
		}
		
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
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
class DragData{
	private var _dragTarget:DisplayObject;
	private var _dragClone : Sprite;
	private var _swapTarget : DisplayObject;
	
	public function init():void{
		_dragTarget = null;
		_dragClone = null;
		_swapTarget = null;
	}

	public function get dragTarget() : DisplayObject {
		return _dragTarget;
	}

	public function set dragTarget(dragTarget : DisplayObject) : void {
		_dragTarget = dragTarget;
		_dragClone = createDragClone(dragTarget)
	}
	
	private function createDragClone(target:DisplayObject):Sprite{
		var sp:Sprite = new Sprite()
		var bd:BitmapData = new BitmapData(target.width, target.height);
		bd.draw(target);
		sp.addChild(new Bitmap(bd));
		sp.x = target.x;
		sp.y = target.y;
		sp.alpha = .8;
		return sp;
	}

	public function get dragClone() : Sprite {
		return _dragClone;
	}

	public function get swapTarget() : DisplayObject {
		return _swapTarget;
	}
	
	public function set swapTarget(swapTarget : DisplayObject) : void{
		_swapTarget=swapTarget;
	}
	
	
}