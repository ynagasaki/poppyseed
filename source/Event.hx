
package ;

class Event {
	public var delay : Float = 0.0;
	public var dependentEvents : List<Event>;

	public function new(delay : Float = 0.0) : Void {
		this.delay = delay;
		dependentEvents = new List<Event>();
	}

	public function start() : Void {
	}

	public function process(elapsedTime : Float) : Bool {
		return true;
	}

	public function chain(event : Event) : Event {
		dependentEvents.add(event);
		return event;
	}
}