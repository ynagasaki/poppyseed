
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

	public static function fromJson(json : Dynamic) : Level {
		var lvl : Level = new Level();
		var foods : Array<Dynamic> = json.food;
		var obstacles : Array<Dynamic> = json.obstacles;

		lvl.distance = json.distance;

		for(food in foods) {
			lvl.add(new FoodItem(food.name, food.x, food.y, food.hp));
		}

		/*for(obstacle in obstacles) {
			lvl.add(new )
		}*/
		var thorns : FlxSprite = new FlxSprite(0, 0);
		thorns.loadGraphic("assets/images/obstacle-thorns.png");
		thorns.x = 2000;
		thorns.y = FlxG.height - thorns.height;
		lvl.add(thorns);

		return lvl;
	}
}