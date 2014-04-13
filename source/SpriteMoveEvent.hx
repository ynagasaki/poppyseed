
package ;

import flixel.FlxSprite;
import flixel.util.FlxPoint;

class SpriteMoveEvent extends Event {
	public var sprite : FlxSprite;
	public var distance : FlxPoint;
	public var duration : Float;

	private var origin : FlxPoint;
	private var pps : FlxPoint;

	public function new(spr : FlxSprite, dist : FlxPoint, duration : Float, delay : Float = 0.0) : Void {
		super(delay);

		sprite = spr;
		distance = dist;
		this.duration = duration;

		pps = new FlxPoint(dist.x / duration, dist.y / duration);
	}

	public override function start() : Void {
		origin = new FlxPoint(sprite.x, sprite.y);
	}

	public override function process(elapsedTime : Float) : Bool {
		duration -= elapsedTime;

		sprite.x += pps.x * elapsedTime;
		sprite.y += pps.y * elapsedTime;

		if(duration <= 0) {
			sprite.x = origin.x + distance.x;
			sprite.y = origin.y + distance.y;
			return true;
		}

		return false;
	}
}