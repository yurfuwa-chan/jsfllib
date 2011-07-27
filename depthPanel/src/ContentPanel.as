package {
	import com.bit101.components.Label;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * @author kaede
	 */
	public class ContentPanel extends Sprite {
		
		private var _type : String;
		private var icon : Bitmap;
		private var label : Label;
		private var _index : int;

		public function ContentPanel(name : String, type : String,index:int) {
			buttonMode = true;
			_type = type;
			_index = index;
			this.name = name;
			this.icon = new Icon[type.toLocaleUpperCase()];
			label = new Label(this)
			create();
		}
	
		private function create() : void {
			graphics.beginFill(0xdddddd);
			graphics.lineStyle(.5,0xededed);
			graphics.drawRect(0, 0, 200, 20);
			addChild(icon)
			label.text = this.name;
			label.y = icon.x = icon.y = 2
			label.x = 30;
		}
	
		public function get type() : String {
			return _type;
		}
	
		public function get index() : int {
			return _index;
		}
		
	}
}
