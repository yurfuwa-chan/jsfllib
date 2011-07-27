package {
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @author kaede
	 */
	public class RearrangeEvent extends Event {
		public static const CHANGE : String = "rearrange_event_change";
		private var _to : DisplayObject;
		private var _from : DisplayObject;
		
		public function RearrangeEvent(type : String, from:DisplayObject,to: DisplayObject, bubbles : Boolean = false, cancelable : Boolean = false) {
			_from = from;
			_to = to;
			super(type, bubbles, cancelable);
		}
		override public function clone() : Event {
			return new RearrangeEvent(type,from,to,bubbles,cancelable);
		}
		
		override public function toString() : String {
			return super.toString();
		}

		public function get to() : DisplayObject {
			return _to;
		}

		public function get from() : DisplayObject {
			return _from;
		}

	}
}
