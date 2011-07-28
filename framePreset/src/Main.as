package {
	import com.bit101.components.Label;
	import com.bit101.components.HBox;
	import com.bit101.components.List;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class Main extends Sprite{
		
		private var preset:JSFLProxy;
		private var box:HBox;
		private var list:List;
		private var buttonBox:VBox;
		private var addButton:PushButton;
		private var applyButton:PushButton;
		private var removeButton:PushButton;
		
		
		public function Main(){
			preset = new JSFLProxy(JSFLProxy.CONFIG_URI+"Javascript/FramePreset.jsfl");
			createView(); 
			registeEventListener();
			update(XML(preset.readPreset()))
		}

		private function createView() : void {
			box = new HBox(this);
			box.x = 10;
			box.y = 10;
			list = new List(box);
			list.width = 200;
			buttonBox = new VBox(box);
			buttonBox.spacing = 7;
			new Label(buttonBox,0,0,"Frame Preset")
			addButton = new PushButton(buttonBox,0,0,"add");
			removeButton = new PushButton(buttonBox,0,0,"remove");
			applyButton = new PushButton(buttonBox,0,0,"apply");
		}
		
		private function registeEventListener() : void {
			addEventListener(MouseEvent.CLICK, clickHandler)
		}
		
		private function clickHandler(event : MouseEvent) : void {
			switch(event.target){
				case addButton:
					update(XML(preset.addPreset()));
				break;
				case removeButton:
					update(XML(preset.removePreset(list.selectedItem.label)));
				break;
				case applyButton:
					preset.applyPreset(list.selectedItem.label);
				break;
			}
		}
		
		public function update(presets:XML):void{
			list.removeAll();
			for each(var preset:XML in presets.preset){
				list.addItemAt({label:preset.@name.toString()},0);
			}
			list.draw();
		}
	}
}
