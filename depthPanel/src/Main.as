package {
	import com.bit101.components.VBox;

	import flash.display.Sprite;

	public class Main extends Sprite {
		
		private var rBox : RearrangeBox;
		private var proxy : JSFLProxy;	
		
		public function Main() {
			proxy = new JSFLProxy(JSFLProxy.CONFIG_URI+"Javascript/DepthPanel.jsfl");
			var vbox:VBox = new VBox(this);
			rBox = vbox.addChild(new RearrangeBox) as RearrangeBox;
			//並べ替えイベント
			rBox.addEventListener(RearrangeEvent.CHANGE, changeHandler);
			//JSFLからのイベント
			proxy.addCallback("setSelectionXML", setSelectionXML)
			proxy.init()
		}

		/**
		 * JSFLからの呼び出しメソッド
		 */
		public function setSelectionXML(str:String) : void {
			if(!str)return;
			var xml:XML = XML(unescape(str));
			rBox.removeChildren();
			for each(var element:XML in xml.element){
				rBox.addChild(new ContentPanel(element.@name,element.@type,element.@index))
			}
		}

		private function changeHandler(event : RearrangeEvent) : void {
			var from:ContentPanel = event.from as ContentPanel; 
			var to:ContentPanel = event.to as ContentPanel;
			proxy.swapIndex(from.index,to.index); 
		}
		
	}
}

