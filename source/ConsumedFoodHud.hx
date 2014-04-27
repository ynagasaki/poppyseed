
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

	public function addFoodItem(item : FoodItem) : Void {
		item.scale.x = 30 / item.width;
		item.scale.y = 30 / item.width;

		consumedFood.add(item);
		item.x = displayWidth;
		item.y = 0;
		displayWidth += item.width * item.scale.x + 5;
		item.scrollFactor = new FlxPoint(0, 0);
		add(item);
	}

	public function full() : Bool {
		return consumedFood.length == 3;
	}

	public function getCommonFoodType() : String {
		var result : String = "";
		for(food in consumedFood) {
			var currName : String = food.getName();
			if(result == "") {
				result = currName;
			} else if(result != currName) {
				return "";
			}
		}
		return result;
	}

	public function clearHud() : Void {
		for(food in consumedFood) {
			food.kill();
		}

		clear();
		consumedFood.clear();
		displayWidth = 0;
	}
}