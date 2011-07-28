package {
	import flash.external.ExternalInterface;
	import adobe.utils.MMExecute;

	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	dynamic public class JSFLProxy extends Proxy {
		
		private var url:String;
		public static const CONFIG_URI:String = 'fl.configURI+"';
		
		public function JSFLProxy(url:String) {
			this.url = url;
			runScript(this.url+'"');
		}
		
		override flash_proxy function callProperty(name : *, ...args) : * {
			args = args || [];
			args.unshift(name || ""); 
			return call.apply(null,args);
		}
		
		private function call(name:String="",...params):String{
			var order:Array = [];
			if(params)order = order.concat(params);
			var str:String = '"'+order.join('","')+'"';
			return MMExecute(name+"("+str+")");
		}
		
		private function runScript(str:String):String{
			return MMExecute("fl.runScript("+str+")");
		}
		
		public function addCallback(functionName:String,closure:Function):void{
			ExternalInterface.addCallback(functionName, closure);
		}
		
		
	}
}
