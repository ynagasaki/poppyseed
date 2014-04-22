
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
		var foods : Array<Dynamic> = json.food;

		lvl.distance = json.distance;

		for(food in foods) {
			lvl.add(new FoodItem(food.name, food.x, food.y, food.hp));
		}

		return lvl;
	}
}