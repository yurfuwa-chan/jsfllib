package {
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	import adobe.utils.MMExecute;
	/**
	 * @author kaede
	 */
	dynamic public class FramePreset extends Proxy {
		
		
		override flash_proxy function callProperty(name : *, ...args) : * {
			args = args || [];
			args.unshift(name || ""); 
			return call.apply(null,args);
		}
		
		
		private function call(name:String="",...params):String{
			var uri:String = 'fl.configURI+"Javascript/FramePreset.jsfl';
			var order:Array = [uri];
			if(name)order.push(name);
			if(params)order = order.concat(params);
			var str:String = order.join('","')+'"';
			return MMExecute("fl.runScript("+str+")");
		}
		
		
	}
}
