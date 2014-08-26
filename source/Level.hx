
package ;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;

class Level extends FlxSpriteGroup {
	public var background : String;
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

	public static function fromJson(json : Dynamic) : Level {
		var lvl : Level = new Level();

		lvl.distance = json.width;

		if(json.starcoins != null) {
			var starcoins : Array<Dynamic> = json.starcoins;
			for(starcoin in starcoins) {
				lvl.add(new StarCoin(starcoin.x, starcoin.y));
			}
		}

		if(json.background != null) {
			lvl.background = json.background;
		}

		return lvl;
	}
}