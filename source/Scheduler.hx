
package ;

import flixel.FlxG;

class Scheduler {
	private var unstartedEvents : List<Event> = null;
	private var startedEvents : List<Event> = null;

	public function new() : Void {
		unstartedEvents = new List<Event>();
		startedEvents = new List<Event>();
	}

	public function process() : Void {
		var finished : List<Event> = new List<Event>();
		var started : List<Event> = new List<Event>();
		var elapsedTime : Float = FlxG.elapsed;

		for(event in unstartedEvents) {
			if(event.delay > 0) {
				event.delay -= elapsedTime;
			}
			if(event.delay <= 0) {
				event.start();
				startedEvents.add(event);
				started.add(event);
			}
		}

		for(event in started) {
			unstartedEvents.remove(event);
		}

		for(event in startedEvents) {
			if(event.process(FlxG.elapsed)) {
				finished.add(event);
			}
		}

		for(event in finished) {
			startedEvents.remove(event);
			for(dependentEvent in event.dependentEvents) {
				unstartedEvents.add(dependentEvent);
			}
		}
	}

	public function addEvent(event : Event) : Void {
		unstartedEvents.add(event);
	}
}