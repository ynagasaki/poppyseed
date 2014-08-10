
package ;

import flixel.FlxG;
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

	public static function fromJson(json : Dynamic) : Level {
		var lvl : Level = new Level();

		lvl.distance = json.distance;

		if(json.starcoins != null) {
			var starcoins : Array<Dynamic> = json.starcoins;
			for(starcoin in starcoins) {
				lvl.add(new StarCoin(starcoin.x, starcoin.y));
			}
		}

		return lvl;
	}
}