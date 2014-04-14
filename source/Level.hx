
package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class Level extends FlxSpriteGroup {
	public var distance : Float = 3300;
	public var traveled : Float = 0;

	public function new() : Void {
		super();
	}

	public function moveThroughLevel(speed : Float) : Void {
		var distanceTraveled : Float = speed * FlxG.elapsed;
		this.x -= distanceTraveled;
		traveled += distanceTraveled;
	}
}