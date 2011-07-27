package {
	import com.bit101.components.VBox;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	/**
	 * @author kaede
	 */
	public class VerticalBox extends VBox {
		public function VerticalBox(parent : DisplayObjectContainer = null, xpos : Number = 0, ypos : Number = 0) {
			super(parent, xpos, ypos);
		}
		
		override public function removeChildAt(index : int) : DisplayObject {
			var child:DisplayObject = super.removeChildAt(index);
			child.removeEventListener(Event.RESIZE, onResize);
			invalidate();
			return child;
		}
		
		override public function addChildAt(child : DisplayObject, index : int) : DisplayObject {
			super.addChildAt(child, index);
			child.addEventListener(Event.RESIZE, onResize);
			invalidate();
			return child
		}
		
		override public function swapChildren(child1 : DisplayObject, child2 : DisplayObject) : void {
			super.swapChildren(child1, child2);
			invalidate();
		}
		
		public function removeChildren():void{
			while(numChildren){
				removeChildAt(numChildren-1)
			}
		}
		
	}
}
