
package ;

import flixel.util.FlxPoint;
import flixel.group.FlxSpriteGroup;

class ConsumedFoodHud extends FlxSpriteGroup {
	private var consumedFood : List<FoodItem>;
	private var displayWidth : Float;

	public function new(x : Float, y : Float) {
		super(x, y);
		consumedFood = new List<FoodItem>();
		scrollFactor = new FlxPoint(0, 0);
		displayWidth = 0.0;
	}

	public function addFoodItem(item : FoodItem) {
		item.scale.x = 0.3;
		item.scale.y = 0.3;
		consumedFood.add(item);
		item.x = displayWidth;
		item.y = 0;
		displayWidth += item.width * item.scale.x;
		item.scrollFactor = new FlxPoint(0, 0);
		add(item);
	}
}